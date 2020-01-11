# PhysicsKit
A 2D rigid body physics engine for Xojo. Based on Randy Gaul's [Impulse engine][randy's] and the Java port by [whackashoe][java port].

## TODO

- [ ] Add an option to destroy bodies which fall outside the world's bounds.
- [ ] Add descriptions to all methods and properties in the module
- [ ] Revolute joints
- [ ] Fixed distance joints
- [ ] Allow sleeping bodies
- [ ] Allow "sensor" bodies
- [ ] Allow density to be customised per shape
- [ ] Optimise the broadphase (? spatial hash)
- [ ] Allow `dt` to be specified per World update rather than on creation

## Texts to look at
- Real-Time Collision Detection by Christer Ericson
- Game Physics Engine Developement by Ian Millington


[randy's]: https://www.randygaul.net/projects-open-sources/impulse-engine/
[java port]: https://github.com/ClickerMonkey/ImpulseEngine