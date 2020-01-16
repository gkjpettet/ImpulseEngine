# ImpulseEngine
A 2D rigid body physics engine for Xojo. Based on Randy Gaul's [Impulse engine][randy's].

The engine is complete and functional but is probably best used to learn about 2D vector physics 
rather than in an actual game as it is missing some important features such as joints.

The engine is written in 100% Xojo and has no external dependencies. It uses API 2.0 and therefore requires Xojo 2019 Release 2 to compile. It will not run on iOS due to this limitation.

## Usage
Getting started is a simople as adding the `ImpulseEngine` module to your project. The project includes a simple test bed demo application illustrating how to create bodies and add them to the simulation. I've tried to keep the engine's API simple and have thoroughly documented the code. 

```xojo
Using ImpulseEngine

// I'm assuming your viewport (e.g: canvas control is 640 x 480 pixels).

Var dt As Double = 1/60 // 60 FPS.
Var iterations As Integer = 5

// Create a new world.
Var w As New World(dt, iterations)

// Add a thin box to act as the ground.
Var ground As Body = w.AddBox(320, 471, 639, 8)
ground.IsStatic = True

// Add a circle to the simulation.
Var circ As Body = w.AddCircle(320, 0, 15)

// Add a polygon with some spin.
Var poly As Body = MyWorld.AddPolygon(150, 50, 0, 0, 30, -50, 60, -20, 75, 20, 40, 40)
poly.AngularVelocity = 0.55

// Call World.Update every `dt` seconds.
// Assume we have a Timer elsewhere with an intervale of 1/fps that
// calls `w.Update` and then draws every body in the World in a canavs.
```

[randy's]: https://www.randygaul.net/projects-open-sources/impulse-engine/
