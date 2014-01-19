//
//  SeedShape.m
//  Seed
//
//  Created by Stephen Cussen on 7/12/13.
//  Copyright (c) 2013 Stephen Cussen. All rights reserved.
//

#import "SeedShape.h"

@implementation SeedShape

+(CGPathRef)createCGPathForSeed:(CGFloat)scale {
	// Declare some floats for the outline of the seed
    // Note that this outline is as simple as can be while
    // providing a realistic set of bounds
    float Ax = 0.0 * scale;
	float Ay = 0.0 * scale;
	float Bx = -100.0 * scale;
	float By = 130.0 * scale;
	float Cx = 40.0 * scale;
	float Cy = 250.0 * scale;
    
    // We need this mutable for now. We'll return this cast as non-mutable.
	CGMutablePathRef returnPathRef = CGPathCreateMutable();
    
    // Start
    CGPathMoveToPoint(returnPathRef, NULL, Ax, Ay);
    //Build triangle
    CGPathAddLineToPoint(returnPathRef, NULL, Bx, By);
    CGPathAddLineToPoint(returnPathRef, NULL, Cx, Cy);
    CGPathCloseSubpath(returnPathRef);
    
    // Return the path as a plain CGPathRef
	return (CGPathRef)returnPathRef;

}
@end
