//
//  MyScene.h
//  Seed
//

//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

#define kUpdateInterval (1.0f / 30.0f)
#define kCutoffFrequency 5.0;
#define kLowG -1.225;

@interface MyScene : SKScene {
    CGPathRef seedShape;
    CGPathRef flightPath;
	float scale;
}
@property (assign, nonatomic) CMAcceleration acceleration;
@property float scale;
@property double filterConstant,dt,RC;  //for accelerometer filter
@property CGFloat xxS,yyS,zzS;          //smoothed acclerometer values
@property CGFloat xGFactor,yGFactor;
- (void)updateGravityLocation;
@end
