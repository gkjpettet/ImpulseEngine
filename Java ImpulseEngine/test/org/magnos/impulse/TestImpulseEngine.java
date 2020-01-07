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

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Path2D;

import com.gameprogblog.engine.Game;
import com.gameprogblog.engine.GameLoop;
import com.gameprogblog.engine.GameLoopVariable;
import com.gameprogblog.engine.GameScreen;
import com.gameprogblog.engine.GameState;
import com.gameprogblog.engine.Scene;
import com.gameprogblog.engine.input.GameInput;


public class TestImpulseEngine implements Game
{

	public static void main( String[] args )
	{
		Game game = new TestImpulseEngine();
		GameLoop loop = new GameLoopVariable( 0.1f );
		GameScreen screen = new GameScreen( 640, 480, true, loop, game );
		screen.setBackground( Color.black );
		GameScreen.showWindow( screen, "Impulse Engine - Java" );
	}

	public ImpulseScene impulse;
	public boolean playing;
	public float accumulator;

	@Override
	public void start( Scene scene )
	{
		impulse = new ImpulseScene( ImpulseMath.DT, 10 );

		Body b = null;

		b = impulse.add( new Circle( 30.0f ), 200, 200 );
		b.setStatic();

		b = impulse.add( new Polygon( 200.0f, 10.0f ), 240, 300 );
		b.setStatic();
		b.setOrient( 0 );

		accumulator = 0f;
		playing = true;
	}

	@Override
	public void input( GameInput input )
	{
		if (input.keyDown[KeyEvent.VK_ESCAPE])
		{
			playing = false;
		}

		if (input.keyDown[KeyEvent.VK_SHIFT])
		{
			if (input.mouseUp[MouseEvent.BUTTON1])
			{
				float hw = ImpulseMath.random( 10.0f, 30.0f );
				float hh = ImpulseMath.random( 10.0f, 30.0f );
				
				Body b = impulse.add( new Polygon( hw, hh ), input.mouseX, input.mouseY );
				b.setOrient( 0.0f );
			}
		}
		else
		{
			if (input.mouseUp[MouseEvent.BUTTON1])
			{
				float r = ImpulseMath.random( 10.0f, 50.0f );
				int vertCount = ImpulseMath.random( 3, Polygon.MAX_POLY_VERTEX_COUNT );

				Vec2[] verts = Vec2.arrayOf( vertCount );
				for (int i = 0; i < vertCount; i++)
				{
					verts[i].set( ImpulseMath.random( -r, r ), ImpulseMath.random( -r, r ) );
				}

				Body b = impulse.add( new Polygon( verts ), input.mouseX, input.mouseY );
				b.setOrient( ImpulseMath.random( -ImpulseMath.PI, ImpulseMath.PI ) );
				b.restitution = 0.2f;
				b.dynamicFriction = 0.2f;
				b.staticFriction = 0.4f;
			}
			if (input.mouseUp[MouseEvent.BUTTON3])
			{
				float r = ImpulseMath.random( 10.0f, 30.0f );

				impulse.add( new Circle( r ), input.mouseX, input.mouseY );
			}
		}
	
	}

	@Override
	public void update( GameState state, Scene scene )
	{
		accumulator += state.seconds;

		if (accumulator >= impulse.dt)
		{
			impulse.step();

			accumulator -= impulse.dt;
		}
	}

	@Override
	public void draw( GameState state, Graphics2D gr, Scene scene )
	{
		for (Body b : impulse.bodies)
		{
			if (b.shape instanceof Circle)
			{
				Circle c = (Circle)b.shape;

				float rx = (float)StrictMath.cos( b.orient ) * c.radius;
				float ry = (float)StrictMath.sin( b.orient ) * c.radius;

				gr.setColor( Color.red );
				gr.draw( new Ellipse2D.Float( b.position.x - c.radius, b.position.y - c.radius, c.radius * 2, c.radius * 2 ) );
				gr.draw( new Line2D.Float( b.position.x, b.position.y, b.position.x + rx, b.position.y + ry ) );
			}
			else if (b.shape instanceof Polygon)
			{
				Polygon p = (Polygon)b.shape;

				Path2D.Float path = new Path2D.Float();
				for (int i = 0; i < p.vertexCount; i++)
				{
					Vec2 v = new Vec2( p.vertices[i] );
					b.shape.u.muli( v );
					v.addi( b.position );

					if (i == 0)
					{
						path.moveTo( v.x, v.y );
					}
					else
					{
						path.lineTo( v.x, v.y );
					}
				}
				path.closePath();

				gr.setColor( Color.blue );
				gr.draw( path );
			}
		}

		gr.setColor( Color.white );
		for (Manifold m : impulse.contacts)
		{
			for (int i = 0; i < m.contactCount; i++)
			{
				Vec2 v = m.contacts[i];
				Vec2 n = m.normal;

				gr.draw( new Line2D.Float( v.x, v.y, v.x + n.x * 4.0f, v.y + n.y * 4.0f ) );
			}
		}
	}

	@Override
	public void destroy()
	{
		impulse.clear();
	}

	@Override
	public boolean isPlaying()
	{
		return playing;
	}

}
