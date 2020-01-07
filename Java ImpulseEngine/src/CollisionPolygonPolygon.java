/*
    Copyright (c) 2013 Randy Gaul http://RandyGaul.net

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:
      1. The origin of this software must not be misrepresented; you must not
         claim that you wrote the original software. If you use this software
         in a product, an acknowledgment in the product documentation would be
         appreciated but is not required.
      2. Altered source versions must be plainly marked as such, and must not be
         misrepresented as being the original software.
      3. This notice may not be removed or altered from any source distribution.
      
    Port to Java by Philip Diffenderfer http://magnos.org
*/

package org.magnos.impulse;

public class CollisionPolygonPolygon implements CollisionCallback
{

	public static final CollisionPolygonPolygon instance = new CollisionPolygonPolygon();

	@Override
	public void handleCollision( Manifold m, Body a, Body b )
	{
		Polygon A = (Polygon)a.shape;
		Polygon B = (Polygon)b.shape;
		m.contactCount = 0;

		// Check for a separating axis with A's face planes
		int[] faceA = { 0 };
		float penetrationA = findAxisLeastPenetration( faceA, A, B );
		if (penetrationA >= 0.0f)
		{
			return;
		}

		// Check for a separating axis with B's face planes
		int[] faceB = { 0 };
		float penetrationB = findAxisLeastPenetration( faceB, B, A );
		if (penetrationB >= 0.0f)
		{
			return;
		}

		int referenceIndex;
		boolean flip; // Always point from a to b

		Polygon RefPoly; // Reference
		Polygon IncPoly; // Incident

		// Determine which shape contains reference face
		if (ImpulseMath.gt( penetrationA, penetrationB ))
		{
			RefPoly = A;
			IncPoly = B;
			referenceIndex = faceA[0];
			flip = false;
		}
		else
		{
			RefPoly = B;
			IncPoly = A;
			referenceIndex = faceB[0];
			flip = true;
		}

		// World space incident face
		Vec2[] incidentFace = Vec2.arrayOf( 2 );

		findIncidentFace( incidentFace, RefPoly, IncPoly, referenceIndex );

		// y
		// ^ .n ^
		// +---c ------posPlane--
		// x < | i |\
		// +---+ c-----negPlane--
		// \ v
		// r
		//
		// r : reference face
		// i : incident poly
		// c : clipped point
		// n : incident normal

		// Setup reference face vertices
		Vec2 v1 = RefPoly.vertices[referenceIndex];
		referenceIndex = referenceIndex + 1 == RefPoly.vertexCount ? 0 : referenceIndex + 1;
		Vec2 v2 = RefPoly.vertices[referenceIndex];

		// Transform vertices to world space
		// v1 = RefPoly->u * v1 + RefPoly->body->position;
		// v2 = RefPoly->u * v2 + RefPoly->body->position;
		v1 = RefPoly.u.mul( v1 ).addi( RefPoly.body.position );
		v2 = RefPoly.u.mul( v2 ).addi( RefPoly.body.position );

		// Calculate reference face side normal in world space
		// Vec2 sidePlaneNormal = (v2 - v1);
		// sidePlaneNormal.Normalize( );
		Vec2 sidePlaneNormal = v2.sub( v1 );
		sidePlaneNormal.normalize();

		// Orthogonalize
		// Vec2 refFaceNormal( sidePlaneNormal.y, -sidePlaneNormal.x );
		Vec2 refFaceNormal = new Vec2( sidePlaneNormal.y, -sidePlaneNormal.x );

		// ax + by = c
		// c is distance from origin
		// real refC = Dot( refFaceNormal, v1 );
		// real negSide = -Dot( sidePlaneNormal, v1 );
		// real posSide = Dot( sidePlaneNormal, v2 );
		float refC = Vec2.dot( refFaceNormal, v1 );
		float negSide = -Vec2.dot( sidePlaneNormal, v1 );
		float posSide = Vec2.dot( sidePlaneNormal, v2 );

		// Clip incident face to reference face side planes
		// if(Clip( -sidePlaneNormal, negSide, incidentFace ) < 2)
		if (clip( sidePlaneNormal.neg(), negSide, incidentFace ) < 2)
		{
			return; // Due to floating point error, possible to not have required
						// points
		}

		// if(Clip( sidePlaneNormal, posSide, incidentFace ) < 2)
		if (clip( sidePlaneNormal, posSide, incidentFace ) < 2)
		{
			return; // Due to floating point error, possible to not have required
						// points
		}

		// Flip
		m.normal.set( refFaceNormal );
		if (flip)
		{
			m.normal.negi();
		}

		// Keep points behind reference face
		int cp = 0; // clipped points behind reference face
		float separation = Vec2.dot( refFaceNormal, incidentFace[0] ) - refC;
		if (separation <= 0.0f)
		{
			m.contacts[cp].set( incidentFace[0] );
			m.penetration = -separation;
			++cp;
		}
		else
		{
			m.penetration = 0;
		}

		separation = Vec2.dot( refFaceNormal, incidentFace[1] ) - refC;

		if (separation <= 0.0f)
		{
			m.contacts[cp].set( incidentFace[1] );

			m.penetration += -separation;
			++cp;

			// Average penetration
			m.penetration /= cp;
		}

		m.contactCount = cp;
	}

	public float findAxisLeastPenetration( int[] faceIndex, Polygon A, Polygon B )
	{
		float bestDistance = -Float.MAX_VALUE;
		int bestIndex = 0;

		for (int i = 0; i < A.vertexCount; ++i)
		{
			// Retrieve a face normal from A
			// Vec2 n = A->m_normals[i];
			// Vec2 nw = A->u * n;
			Vec2 nw = A.u.mul( A.normals[i] );

			// Transform face normal into B's model space
			// Mat2 buT = B->u.Transpose( );
			// n = buT * nw;
			Mat2 buT = B.u.transpose();
			Vec2 n = buT.mul( nw );

			// Retrieve support point from B along -n
			// Vec2 s = B->GetSupport( -n );
			Vec2 s = B.getSupport( n.neg() );

			// Retrieve vertex on face from A, transform into
			// B's model space
			// Vec2 v = A->m_vertices[i];
			// v = A->u * v + A->body->position;
			// v -= B->body->position;
			// v = buT * v;
			Vec2 v = buT.muli( A.u.mul( A.vertices[i] ).addi( A.body.position ).subi( B.body.position ) );

			// Compute penetration distance (in B's model space)
			// real d = Dot( n, s - v );
			float d = Vec2.dot( n, s.sub( v ) );

			// Store greatest distance
			if (d > bestDistance)
			{
				bestDistance = d;
				bestIndex = i;
			}
		}

		faceIndex[0] = bestIndex;
		return bestDistance;
	}

	public void findIncidentFace( Vec2[] v, Polygon RefPoly, Polygon IncPoly, int referenceIndex )
	{
		Vec2 referenceNormal = RefPoly.normals[referenceIndex];

		// Calculate normal in incident's frame of reference
		// referenceNormal = RefPoly->u * referenceNormal; // To world space
		// referenceNormal = IncPoly->u.Transpose( ) * referenceNormal; // To
		// incident's model space
		referenceNormal = RefPoly.u.mul( referenceNormal ); // To world space
		referenceNormal = IncPoly.u.transpose().mul( referenceNormal ); // To
																								// incident's
																								// model
																								// space

		// Find most anti-normal face on incident polygon
		int incidentFace = 0;
		float minDot = Float.MAX_VALUE;
		for (int i = 0; i < IncPoly.vertexCount; ++i)
		{
			// real dot = Dot( referenceNormal, IncPoly->m_normals[i] );
			float dot = Vec2.dot( referenceNormal, IncPoly.normals[i] );

			if (dot < minDot)
			{
				minDot = dot;
				incidentFace = i;
			}
		}

		// Assign face vertices for incidentFace
		// v[0] = IncPoly->u * IncPoly->m_vertices[incidentFace] +
		// IncPoly->body->position;
		// incidentFace = incidentFace + 1 >= (int32)IncPoly->m_vertexCount ? 0 :
		// incidentFace + 1;
		// v[1] = IncPoly->u * IncPoly->m_vertices[incidentFace] +
		// IncPoly->body->position;

		v[0] = IncPoly.u.mul( IncPoly.vertices[incidentFace] ).addi( IncPoly.body.position );
		incidentFace = incidentFace + 1 >= (int)IncPoly.vertexCount ? 0 : incidentFace + 1;
		v[1] = IncPoly.u.mul( IncPoly.vertices[incidentFace] ).addi( IncPoly.body.position );
	}

	public int clip( Vec2 n, float c, Vec2[] face )
	{
		int sp = 0;
		Vec2[] out = {
			new Vec2( face[0] ),
			new Vec2( face[1] )
		};

		// Retrieve distances from each endpoint to the line
		// d = ax + by - c
		// real d1 = Dot( n, face[0] ) - c;
		// real d2 = Dot( n, face[1] ) - c;
		float d1 = Vec2.dot( n, face[0] ) - c;
		float d2 = Vec2.dot( n, face[1] ) - c;

		// If negative (behind plane) clip
		// if(d1 <= 0.0f) out[sp++] = face[0];
		// if(d2 <= 0.0f) out[sp++] = face[1];
		if (d1 <= 0.0f) out[sp++].set( face[0] );
		if (d2 <= 0.0f) out[sp++].set( face[1] );

		// If the points are on different sides of the plane
		if (d1 * d2 < 0.0f) // less than to ignore -0.0f
		{
			// Push intersection point
			// real alpha = d1 / (d1 - d2);
			// out[sp] = face[0] + alpha * (face[1] - face[0]);
			// ++sp;

			float alpha = d1 / (d1 - d2);

			out[sp++].set( face[1] ).subi( face[0] ).muli( alpha ).addi( face[0] );
		}

		// Assign our new converted values
		face[0] = out[0];
		face[1] = out[1];

		// assert( sp != 3 );

		return sp;
	}

}
