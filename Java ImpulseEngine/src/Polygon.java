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

public class Polygon extends Shape
{

	public static final int MAX_POLY_VERTEX_COUNT = 64;

	public int vertexCount;
	public Vec2[] vertices = Vec2.arrayOf( MAX_POLY_VERTEX_COUNT );
	public Vec2[] normals = Vec2.arrayOf( MAX_POLY_VERTEX_COUNT );

	public Polygon()
	{
	}
	
	public Polygon( Vec2 ... verts)
	{
		set( verts );
	}
	
	public Polygon( float hw, float hh )
	{
		setBox( hw, hh );
	}
	
	@Override
	public Shape clone()
	{
//		PolygonShape *poly = new PolygonShape( );
//	    poly->u = u;
//	    for(uint32 i = 0; i < m_vertexCount; ++i)
//	    {
//	      poly->m_vertices[i] = m_vertices[i];
//	      poly->m_normals[i] = m_normals[i];
//	    }
//	    poly->m_vertexCount = m_vertexCount;
//	    return poly;

		Polygon p = new Polygon();
		p.u.set( u );
		for (int i = 0; i < vertexCount; i++)
		{
			p.vertices[i].set( vertices[i] );
			p.normals[i].set( normals[i] );
		}
		p.vertexCount = vertexCount;

		return p;
	}

	@Override
	public void initialize()
	{
		computeMass( 1.0f );
	}

	@Override
	public void computeMass( float density )
	{
		// Calculate centroid and moment of inertia
		Vec2 c = new Vec2( 0.0f, 0.0f ); // centroid
		float area = 0.0f;
		float I = 0.0f;
		final float k_inv3 = 1.0f / 3.0f;

		for (int i = 0; i < vertexCount; ++i)
		{
			// Triangle vertices, third vertex implied as (0, 0)
			Vec2 p1 = vertices[i];
			Vec2 p2 = vertices[(i + 1) % vertexCount];

			float D = Vec2.cross( p1, p2 );
			float triangleArea = 0.5f * D;

			area += triangleArea;

			// Use area to weight the centroid average, not just vertex position
			float weight = triangleArea * k_inv3;
			c.addsi( p1, weight );
			c.addsi( p2, weight );

			float intx2 = p1.x * p1.x + p2.x * p1.x + p2.x * p2.x;
			float inty2 = p1.y * p1.y + p2.y * p1.y + p2.y * p2.y;
			I += (0.25f * k_inv3 * D) * (intx2 + inty2);
		}

		c.muli( 1.0f / area );

		// Translate vertices to centroid (make the centroid (0, 0)
		// for the polygon in model space)
		// Not really necessary, but I like doing this anyway
		for (int i = 0; i < vertexCount; ++i)
		{
			vertices[i].subi( c );
		}

		body.mass = density * area;
		body.invMass = (body.mass != 0.0f) ? 1.0f / body.mass : 0.0f;
		body.inertia = I * density;
		body.invInertia = (body.inertia != 0.0f) ? 1.0f / body.inertia : 0.0f;
	}

	@Override
	public void setOrient( float radians )
	{
		u.set( radians );
	}

	@Override
	public Type getType()
	{
		return Type.Poly;
	}

	public void setBox( float hw, float hh )
	{
		vertexCount = 4;
		vertices[0].set( -hw, -hh );
		vertices[1].set( hw, -hh );
		vertices[2].set( hw, hh );
		vertices[3].set( -hw, hh );
		normals[0].set( 0.0f, -1.0f );
		normals[1].set( 1.0f, 0.0f );
		normals[2].set( 0.0f, 1.0f );
		normals[3].set( -1.0f, 0.0f );
	}

	public void set( Vec2... verts )
	{
		// Find the right most point on the hull
		int rightMost = 0;
		float highestXCoord = verts[0].x;
		for (int i = 1; i < verts.length; ++i)
		{
			float x = verts[i].x;

			if (x > highestXCoord)
			{
				highestXCoord = x;
				rightMost = i;
			}
			// If matching x then take farthest negative y
			else if (x == highestXCoord)
			{
				if (verts[i].y < verts[rightMost].y)
				{
					rightMost = i;
				}
			}
		}

		int[] hull = new int[MAX_POLY_VERTEX_COUNT];
		int outCount = 0;
		int indexHull = rightMost;

		for (;;)
		{
			hull[outCount] = indexHull;

			// Search for next index that wraps around the hull
			// by computing cross products to find the most counter-clockwise
			// vertex in the set, given the previos hull index
			int nextHullIndex = 0;
			for (int i = 1; i < verts.length; ++i)
			{
				// Skip if same coordinate as we need three unique
				// points in the set to perform a cross product
				if (nextHullIndex == indexHull)
				{
					nextHullIndex = i;
					continue;
				}

				// Cross every set of three unique vertices
				// Record each counter clockwise third vertex and add
				// to the output hull
				// See : http://www.oocities.org/pcgpe/math2d.html
				Vec2 e1 = verts[nextHullIndex].sub( verts[hull[outCount]] );
				Vec2 e2 = verts[i].sub( verts[hull[outCount]] );
				float c = Vec2.cross( e1, e2 );
				if (c < 0.0f)
				{
					nextHullIndex = i;
				}

				// Cross product is zero then e vectors are on same line
				// therefore want to record vertex farthest along that line
				if (c == 0.0f && e2.lengthSq() > e1.lengthSq())
				{
					nextHullIndex = i;
				}
			}

			++outCount;
			indexHull = nextHullIndex;

			// Conclude algorithm upon wrap-around
			if (nextHullIndex == rightMost)
			{
				vertexCount = outCount;
				break;
			}
		}

		// Copy vertices into shape's vertices
		for (int i = 0; i < vertexCount; ++i)
		{
			vertices[i].set( verts[hull[i]] );
		}

		// Compute face normals
		for (int i = 0; i < vertexCount; ++i)
		{
			Vec2 face = vertices[(i + 1) % vertexCount].sub( vertices[i] );

			// Calculate normal with 2D cross product between vector and scalar
			normals[i].set( face.y, -face.x );
			normals[i].normalize();
		}
	}

	public Vec2 getSupport( Vec2 dir )
	{
		float bestProjection = -Float.MAX_VALUE;
		Vec2 bestVertex = null;

		for (int i = 0; i < vertexCount; ++i)
		{
			Vec2 v = vertices[i];
			float projection = Vec2.dot( v, dir );

			if (projection > bestProjection)
			{
				bestVertex = v;
				bestProjection = projection;
			}
		}

		return bestVertex;
	}

}
