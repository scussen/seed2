//
//  MyScene.m
//  Seed
//
//  Created by Stephen Cussen on 7/11/13.
//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import "MyScene.h"
#import "SeedShape.h"
#import "FlightPath.h"

@implementation MyScene

@synthesize scale;
@synthesize acceleration;
@synthesize filterConstant,dt,RC;  //for accelerometer filter
@synthesize xxS, yyS, zzS;         //smoothed acclerometer values
@synthesize xGFactor,yGFactor;     //factor for tilt gravity

static SKLabelNode *myLabel;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        
        // Add the instructions
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-UltraLight"];
        myLabel.text = @"Touch";
        myLabel.fontSize = 50;
        myLabel.alpha = 0.0;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        SKAction *delay = [SKAction waitForDuration:4.0];
        SKAction *fadeIn = [SKAction fadeInWithDuration:12.0];
        [myLabel runAction:[SKAction sequence:@[delay, fadeIn]]];
        [self addChild:myLabel];
        
        // set up the seed constraints
        scale = 0.25;
        seedShape = [SeedShape createCGPathForSeed:scale];
        flightPath = [FlightPath createCGPathForFlight];
        
        // fly a seed across the scene
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Seed"];
        sprite.position = CGPointMake(300,120);
        sprite.xScale = scale;
        sprite.yScale = scale;

        
        SKAction *seedFlight = [SKAction followPath:flightPath asOffset:YES orientToPath:NO duration:9.5];
        SKAction *playMusic = [SKAction playSoundFileNamed:@"flight.caf" waitForCompletion:NO];
        [sprite runAction:[SKAction sequence:@[playMusic, seedFlight]]];

        [self addChild:sprite];
        
        /*
         //This code is to read the seed outline path from a file...
         if (self) {
            NSString *fileText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
              //pathForResource:@"DandelionSeedPathV2"
                pathForResource:@"Shape"
                ofType:@"txt"]
                encoding:NSUTF8StringEncoding error:nil];
            seedShape = [ShapeUtilities createCGPathRefFromEPSString:fileText];

            scale = 1.0;
        }
        */
        
        //code added for the accelerometer calcs
        //set up the filter constants
        dt = kUpdateInterval;
        RC = 1.0/kCutoffFrequency;
        filterConstant = dt/(dt +RC);
        
        //seed the smoothed x,y,z acceleration to that of normal
        self.xxS = 0.0;
        self.yyS = -1.0;
        self.zzS = 0.0;
        
        //set up the default gravity (down to the bottom of the scene)
        self.physicsWorld.gravity = CGVectorMake(0.0, -1.225);
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        if (myLabel != NULL) {
            SKAction *fade = [SKAction fadeOutWithDuration:1.0];
            SKAction *remove = [SKAction removeFromParent];
            [myLabel runAction:[SKAction sequence:@[fade, remove]]];
            
        }
        
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Seed"];
        
        sprite.position = location;
        sprite.xScale = scale;
        sprite.yScale = scale;
        sprite.anchorPoint = CGPointMake(0.65,0.0);
        //sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
        sprite.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:seedShape];
        sprite.physicsBody.mass = .0001;
        sprite.physicsBody.linearDamping = 0.98;
        sprite.physicsBody.restitution = 0.05;
        
        // make gravity a little less - now done in initWithSize
        //self.physicsWorld.gravity = CGPointMake(0.0, -1.225);
        
        // bound the scene's physicsBody
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //SKAction *action = [SKAction followPath:flightPath duration:4.5];
        //[sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

// this is called from the block every time we get a movement update
- (void)updateGravityLocation {
    float xx = acceleration.x;
    float yy = acceleration.y;
    float zz = acceleration.z;
    
    // lowpass filter to smooth the accelerometer input
    double alpha = filterConstant;
    
    xxS = xx * alpha + xxS * (1.0 - alpha);
	yyS = yy * alpha + yyS * (1.0 - alpha);
	zzS = zz * alpha + zzS * (1.0 - alpha);
    
    xGFactor = -xxS;
    yGFactor = -yyS;
    
    self.physicsWorld.gravity = CGVectorMake(-1.225 * xGFactor, -1.225 * yGFactor);
}

@end
