//
//  FlightPath.m
//  Seed
//
//  Created by Stephen Cussen on 7/13/13.
//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import "FlightPath.h"

@implementation FlightPath {
}
+ (CGPathRef)createCGPathForFlight
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(0, 240)];
    [bezierPath addCurveToPoint:CGPointMake(360, 160) controlPoint1:CGPointMake(220,260) controlPoint2:CGPointMake(200, 160)];

    return bezierPath.CGPath;
}


@end
