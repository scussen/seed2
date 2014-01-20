seed2
=====

iOS Sprite Kit example using the accelerometer and music intro

Intro sequences

Both, the seed floating across the screen while the music plays and the ‘Touch’ text fading in after a delay are examples of a sequence

Sprite Kit is used for the seeds and the physics environment

For the seeds we have an image (seed.png) and a boundary (defined in SeedShape.m) to define the shape of the seed for collisions in the physics model.  The seed image overlaid with the physics boundary in green - image here: [Boundary Overlay on Seed](https://github.com/scussen/seed2/blob/master/Seed/SeedCompositeOverlay.png)

The intial flight of the seed in the intro is defined by a bezier path in FlightPath.m

Core Motion is used for access to the accelerometers

The motion manager is initialized causing accelerometer updates to be queued and execution a block when motion is detected that includes the execution of the updateGravityLocation method in MyScene.m

Build/Run
This code can be run on the simulator however, you will not have the benefit of the accelerometer – so ‘gravity’ will not move ☺

After the intro each touch will generate a seed
