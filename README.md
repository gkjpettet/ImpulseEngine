# PhysicsKit
A 2D rigid body physics engine for Xojo. Based on Randy Gaul's [Impulse engine][randy's] and the Java port by [whackashoe][java port].

## Port process
- [x] Body.java
- [x] Circle.java
- [x] CollisionCallback.java
- [x] CollisionCircleCircle.java
- [ ] CollisionCirclePolygon.java
- [ ] CollisionPolygonCircle.java
- [ ] CollisionPolygonPolygon
- [x] Collisions.java
- [x] ImpulseMath.java (renamed to PhysicsKit.Maths)
- [x] ImpulseScene.java (renamed to World)
- [x] Manifold.java
- [x] Mat2.java
- [x] Polygon.java
- [x] Shape.java
- [x] Vec2.java (renamed to Vector)

### Manifold.java

`Manifold.e` renamed to `Restitution`.
`Manifold.sf` renamed to `StaticFriction`.
`Manifold.df` renamed to `DynamicFriction`.

[randy's]: https://www.randygaul.net/projects-open-sources/impulse-engine/
[java port]: https://github.com/ClickerMonkey/ImpulseEngine