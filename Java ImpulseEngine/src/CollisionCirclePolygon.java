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

public class CollisionCirclePolygon implements CollisionCallback
{

	public static final CollisionCirclePolygon instance = new CollisionCirclePolygon();

	@Override
	public void handleCollision( Manifold m, Body a, Body b )
	{
		Circle A = (Circle)a.shape;
		Polygon B = (Polygon)b.shape;

		m.contactCount = 0;

		// Transform circle center to Polygon model space
		// Vec2 center = a->position;
		// center = B->u.Transpose( ) * (center - b->position);
		Vec2 center = B.u.transpose().muli( a.position.sub( b.position ) );

		// Find edge with minimum penetration
		// Exact concept as using support points in Polygon vs Polygon
		float separation = -Float.MAX_VALUE;
		int faceNormal = 0;
		for (int i = 0; i < B.vertexCount; ++i)
		{
			// real s = Dot( B->m_normals[i], center - B->m_vertices[i] );
			float s = Vec2.dot( B.normals[i], center.sub( B.vertices[i] ) );

			if (s > A.radius)
			{
				return;
			}

			if (s > separation)
			{
				separation = s;
				faceNormal = i;
			}
		}

		// Grab face's vertices
		Vec2 v1 = B.vertices[faceNormal];
		int i2 = faceNormal + 1 < B.vertexCount ? faceNormal + 1 : 0;
		Vec2 v2 = B.vertices[i2];

		// Check to see if center is within polygon
		if (separation < ImpulseMath.EPSILON)
		{
			// m->contact_count = 1;
			// m->normal = -(B->u * B->m_normals[faceNormal]);
			// m->contacts[0] = m->normal * A->radius + a->position;
			// m->penetration = A->radius;

			m.contactCount = 1;
			B.u.mul( B.normals[faceNormal], m.normal ).negi();
			m.contacts[0].set( m.normal ).muli( A.radius ).addi( a.position );
			m.penetration = A.radius;
			return;
		}

		// Determine which voronoi region of the edge center of circle lies within
		// real dot1 = Dot( center - v1, v2 - v1 );
		// real dot2 = Dot( center - v2, v1 - v2 );
		// m->penetration = A->radius - separation;
		float dot1 = Vec2.dot( center.sub( v1 ), v2.sub( v1 ) );
		float dot2 = Vec2.dot( center.sub( v2 ), v1.sub( v2 ) );
		m.penetration = A.radius - separation;

		// Closest to v1
		if (dot1 <= 0.0f)
		{
			if (Vec2.distanceSq( center, v1 ) > A.radius * A.radius)
			{
				return;
			}

			// m->contact_count = 1;
			// Vec2 n = v1 - center;
			// n = B->u * n;
			// n.Normalize( );
			// m->normal = n;
			// v1 = B->u * v1 + b->position;
			// m->contacts[0] = v1;

			m.contactCount = 1;
			B.u.muli( m.normal.set( v1 ).subi( center ) ).normalize();
			B.u.mul( v1, m.contacts[0] ).addi( b.position );
		}

		// Closest to v2
		else if (dot2 <= 0.0f)
		{
			if (Vec2.distanceSq( center, v2 ) > A.radius * A.radius)
			{
				return;
			}

			// m->contact_count = 1;
			// Vec2 n = v2 - center;
			// v2 = B->u * v2 + b->position;
			// m->contacts[0] = v2;
			// n = B->u * n;
			// n.Normalize( );
			// m->normal = n;

			m.contactCount = 1;
			B.u.muli( m.normal.set( v2 ).subi( center ) ).normalize();
			B.u.mul( v2, m.contacts[0] ).addi( b.position );
		}

		// Closest to face
		else
		{
			Vec2 n = B.normals[faceNormal];

			if (Vec2.dot( center.sub( v1 ), n ) > A.radius)
			{
				return;
			}

			// n = B->u * n;
			// m->normal = -n;
			// m->contacts[0] = m->normal * A->radius + a->position;
			// m->contact_count = 1;

			m.contactCount = 1;
			B.u.mul( n, m.normal ).negi();
			m.contacts[0].set( a.position ).addsi( m.normal, A.radius );
		}
	}

}
