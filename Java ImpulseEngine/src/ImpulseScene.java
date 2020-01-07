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

import java.util.ArrayList;


public class ImpulseScene
{

	public float dt;
	public int iterations;
	public ArrayList<Body> bodies = new ArrayList<Body>();
	public ArrayList<Manifold> contacts = new ArrayList<Manifold>();

	public ImpulseScene( float dt, int iterations )
	{
		this.dt = dt;
		this.iterations = iterations;
	}

	public void step()
	{
		// Generate new collision info
		contacts.clear();
		for (int i = 0; i < bodies.size(); ++i)
		{
			Body A = bodies.get( i );

			for (int j = i + 1; j < bodies.size(); ++j)
			{
				Body B = bodies.get( j );

				if (A.invMass == 0 && B.invMass == 0)
				{
					continue;
				}

				Manifold m = new Manifold( A, B );
				m.solve();

				if (m.contactCount > 0)
				{
					contacts.add( m );
				}
			}
		}

		// Integrate forces
		for (int i = 0; i < bodies.size(); ++i)
		{
			integrateForces( bodies.get( i ), dt );
		}

		// Initialize collision
		for (int i = 0; i < contacts.size(); ++i)
		{
			contacts.get( i ).initialize();
		}

		// Solve collisions
		for (int j = 0; j < iterations; ++j)
		{
			for (int i = 0; i < contacts.size(); ++i)
			{
				contacts.get( i ).applyImpulse();
			}
		}

		// Integrate velocities
		for (int i = 0; i < bodies.size(); ++i)
		{
			integrateVelocity( bodies.get( i ), dt );
		}

		// Correct positions
		for (int i = 0; i < contacts.size(); ++i)
		{
			contacts.get( i ).positionalCorrection();
		}

		// Clear all forces
		for (int i = 0; i < bodies.size(); ++i)
		{
			Body b = bodies.get( i );
			b.force.set( 0, 0 );
			b.torque = 0;
		}
	}

	public Body add( Shape shape, int x, int y )
	{
		Body b = new Body( shape, x, y );
		bodies.add( b );
		return b;
	}

	public void clear()
	{
		contacts.clear();
		bodies.clear();
	}

	// Acceleration
	// F = mA
	// => A = F * 1/m

	// Explicit Euler
	// x += v * dt
	// v += (1/m * F) * dt

	// Semi-Implicit (Symplectic) Euler
	// v += (1/m * F) * dt
	// x += v * dt

	// see http://www.niksula.hut.fi/~hkankaan/Homepages/gravity.html
	public void integrateForces( Body b, float dt )
	{
//		if(b->im == 0.0f)
//			return;
//		b->velocity += (b->force * b->im + gravity) * (dt / 2.0f);
//		b->angularVelocity += b->torque * b->iI * (dt / 2.0f);

		if (b.invMass == 0.0f)
		{
			return;
		}

		float dts = dt * 0.5f;

		b.velocity.addsi( b.force, b.invMass * dts );
		b.velocity.addsi( ImpulseMath.GRAVITY, dts );
		b.angularVelocity += b.torque * b.invInertia * dts;
	}

	public void integrateVelocity( Body b, float dt )
	{
//		if(b->im == 0.0f)
//			return;
//		b->position += b->velocity * dt;
//		b->orient += b->angularVelocity * dt;
//		b->SetOrient( b->orient );
//		IntegrateForces( b, dt );

		if (b.invMass == 0.0f)
		{
			return;
		}

		b.position.addsi( b.velocity, dt );
		b.orient += b.angularVelocity * dt;
		b.setOrient( b.orient );

		integrateForces( b, dt );
	}

}
