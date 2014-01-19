//
//  ViewController.h
//  Seed
//

//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
