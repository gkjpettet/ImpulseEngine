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

public class Manifold
{

	public Body A;
	public Body B;
	public float penetration;
	public final Vec2 normal = new Vec2();
	public final Vec2[] contacts = { new Vec2(), new Vec2() };
	public int contactCount;
	public float e;
	public float df;
	public float sf;

	public Manifold( Body a, Body b )
	{
		A = a;
		B = b;
	}

	public void solve()
	{
		int ia = A.shape.getType().ordinal();
		int ib = B.shape.getType().ordinal();

		Collisions.dispatch[ia][ib].handleCollision( this, A, B );
	}

	public void initialize()
	{
		// Calculate average restitution
		// e = std::min( A->restitution, B->restitution );
		e = StrictMath.min( A.restitution, B.restitution );

		// Calculate static and dynamic friction
		// sf = std::sqrt( A->staticFriction * A->staticFriction );
		// df = std::sqrt( A->dynamicFriction * A->dynamicFriction );
		sf = (float)StrictMath.sqrt( A.staticFriction * A.staticFriction + B.staticFriction * B.staticFriction);
		df = (float)StrictMath.sqrt( A.dynamicFriction * A.dynamicFriction + B.dynamicFriction * B.dynamicFriction);

		for (int i = 0; i < contactCount; ++i)
		{
			// Calculate radii from COM to contact
			// Vec2 ra = contacts[i] - A->position;
			// Vec2 rb = contacts[i] - B->position;
			Vec2 ra = contacts[i].sub( A.position );
			Vec2 rb = contacts[i].sub( B.position );

			// Vec2 rv = B->velocity + Cross( B->angularVelocity, rb ) -
			// A->velocity - Cross( A->angularVelocity, ra );
			Vec2 rv = B.velocity.add( Vec2.cross( B.angularVelocity, rb, new Vec2() ) ).subi( A.velocity ).subi( Vec2.cross( A.angularVelocity, ra, new Vec2() ) );

			// Determine if we should perform a resting collision or not
			// The idea is if the only thing moving this object is gravity,
			// then the collision should be performed without any restitution
			// if(rv.LenSqr( ) < (dt * gravity).LenSqr( ) + EPSILON)
			if (rv.lengthSq() < ImpulseMath.RESTING)
			{
				e = 0.0f;
			}
		}
	}

	public void applyImpulse()
	{
		// Early out and positional correct if both objects have infinite mass
		// if(Equal( A->im + B->im, 0 ))
		if (ImpulseMath.equal( A.invMass + B.invMass, 0 ))
		{
			infiniteMassCorrection();
			return;
		}

		for (int i = 0; i < contactCount; ++i)
		{
			// Calculate radii from COM to contact
			// Vec2 ra = contacts[i] - A->position;
			// Vec2 rb = contacts[i] - B->position;
			Vec2 ra = contacts[i].sub( A.position );
			Vec2 rb = contacts[i].sub( B.position );

			// Relative velocity
			// Vec2 rv = B->velocity + Cross( B->angularVelocity, rb ) -
			// A->velocity - Cross( A->angularVelocity, ra );
			Vec2 rv = B.velocity.add( Vec2.cross( B.angularVelocity, rb, new Vec2() ) ).subi( A.velocity ).subi( Vec2.cross( A.angularVelocity, ra, new Vec2() ) );

			// Relative velocity along the normal
			// real contactVel = Dot( rv, normal );
			float contactVel = Vec2.dot( rv, normal );

			// Do not resolve if velocities are separating
			if (contactVel > 0)
			{
				return;
			}

			// real raCrossN = Cross( ra, normal );
			// real rbCrossN = Cross( rb, normal );
			// real invMassSum = A->im + B->im + Sqr( raCrossN ) * A->iI + Sqr(
			// rbCrossN ) * B->iI;
			float raCrossN = Vec2.cross( ra, normal );
			float rbCrossN = Vec2.cross( rb, normal );
			float invMassSum = A.invMass + B.invMass + (raCrossN * raCrossN) * A.invInertia + (rbCrossN * rbCrossN) * B.invInertia;

			// Calculate impulse scalar
			float j = -(1.0f + e) * contactVel;
			j /= invMassSum;
			j /= contactCount;

			// Apply impulse
			Vec2 impulse = normal.mul( j );
			A.applyImpulse( impulse.neg(), ra );
			B.applyImpulse( impulse, rb );

			// Friction impulse
			// rv = B->velocity + Cross( B->angularVelocity, rb ) -
			// A->velocity - Cross( A->angularVelocity, ra );
			rv = B.velocity.add( Vec2.cross( B.angularVelocity, rb, new Vec2() ) ).subi( A.velocity ).subi( Vec2.cross( A.angularVelocity, ra, new Vec2() ) );

			// Vec2 t = rv - (normal * Dot( rv, normal ));
			// t.Normalize( );
			Vec2 t = new Vec2( rv );
			t.addsi( normal, -Vec2.dot( rv, normal ) );
			t.normalize();

			// j tangent magnitude
			float jt = -Vec2.dot( rv, t );
			jt /= invMassSum;
			jt /= contactCount;

			// Don't apply tiny friction impulses
			if (ImpulseMath.equal( jt, 0.0f ))
			{
				return;
			}

			// Coulumb's law
			Vec2 tangentImpulse;
			// if(std::abs( jt ) < j * sf)
			if (StrictMath.abs( jt ) < j * sf)
			{
				// tangentImpulse = t * jt;
				tangentImpulse = t.mul( jt );
			}
			else
			{
				// tangentImpulse = t * -j * df;
				tangentImpulse = t.mul( j ).muli( -df );
			}

			// Apply friction impulse
			// A->ApplyImpulse( -tangentImpulse, ra );
			// B->ApplyImpulse( tangentImpulse, rb );
			A.applyImpulse( tangentImpulse.neg(), ra );
			B.applyImpulse( tangentImpulse, rb );
		}
	}

	public void positionalCorrection()
	{
		// const real k_slop = 0.05f; // Penetration allowance
		// const real percent = 0.4f; // Penetration percentage to correct
		// Vec2 correction = (std::max( penetration - k_slop, 0.0f ) / (A->im +
		// B->im)) * normal * percent;
		// A->position -= correction * A->im;
		// B->position += correction * B->im;

		float correction = StrictMath.max( penetration - ImpulseMath.PENETRATION_ALLOWANCE, 0.0f ) / (A.invMass + B.invMass) * ImpulseMath.PENETRATION_CORRETION;

		A.position.addsi( normal, -A.invMass * correction );
		B.position.addsi( normal, B.invMass * correction );
	}

	public void infiniteMassCorrection()
	{
		A.velocity.set( 0, 0 );
		B.velocity.set( 0, 0 );
	}

}
