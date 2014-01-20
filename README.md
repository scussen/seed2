seed2
=====

iOS Sprite Kit example using the accelerometer and music intro

Intro sequences

Both, the seed floating across the screen while the music plays and the ‘Touch’ text fading in after a delay are examples of a sequence

Sprite Kit is used for the seeds and the physics environment

For the seeds we have an image (seed.png) and a boundary (defined in SeedShape.m) to define the shape of the seed for collisions in the physics model.  The seed image overlaid with the physics boundary (in green) is shown here: [Boundary Overlay on Seed](https://github.com/scussen/seed2/blob/master/Seed/SeedCompositeOverlay.png).  I've set the physics boundary to be as simple as possible and smaller than the seed in a way that will allow the 'feathers' to intertwine

The flight of the seed in the intro is defined by a bezier path in FlightPath.m

Core Motion is used for access to the accelerometer

The motion manager is initialized causing accelerometer updates to be queued and execution a block when motion is detected that includes the execution of the updateGravityLocation method in MyScene.m

Build/Run
This code can be run on the simulator however, you will not have the benefit of the accelerometer – so ‘gravity’ will not move ☺

After the intro each touch will generate a seed
