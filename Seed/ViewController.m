//
//  ViewController.m
//  Seed
//
//  Created by Stephen Cussen on 7/11/13.
//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController
@synthesize motionManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
//    uncomment these two lines to see the 'Frames Per Second' rate and 'Number of Sprites' displayed on screen
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
//    the original code that set the view bounds to the visible view size
//    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    // make an extra wide scene so that the seeds can fall out of the view
    CGSize wideScene = skView.bounds.size;
    wideScene.width = wideScene.width * 3;
    MyScene * scene = [MyScene sceneWithSize:wideScene];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    // Set up the Motion Manager and start accelerometer updates to the queue
    // when the motion manager has updates to report it will execute the block that
    // passes the acceleration object into our view and then calls the method named 'updateAI'
    // on the main thread (as UIView objects can only safely be used from the main thread).
    
    self.motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [motionManager startAccelerometerUpdatesToQueue:queue withHandler:
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         [(MyScene *)scene setAcceleration:accelerometerData.acceleration];
         [scene performSelectorOnMainThread:@selector(updateGravityLocation) withObject:nil waitUntilDone:NO];
//  Alternate code suggested by Andrew Stone to replace the 'performSelectorOnMainThread' above:
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [scene updateGravityLocation];
//         });
     }];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
