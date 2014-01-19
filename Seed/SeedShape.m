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
	// Declare some floats for the incoming point data.
	//float Ax = 100.0 * scale;
	//float Ay = 250.0 * scale;
	//float Bx = 0.0 * scale;
	//float By = 120.0 * scale;
	//float Cx = 140.0 * scale;
	//float Cy = 0.0 * scale;
    /*
    float Ax = 0.0 * scale;
	float Ay = 250.0 * scale;
	float Bx = 0.0 * scale;
	float By = 0.0 * scale;
	float Cx = 160.0 * scale;
	float Cy = 0.0 * scale;
    float Dx = 160.0 * scale;
    float Dy = 250.0 * scale;
    */
    /*
    float Ax = 125.0 * scale;
	float Ay = 250.0 * scale;
    float Bx = 0.0 * scale;
	float By = 250.0 * scale;
	float Cx = 0.0 * scale;
	float Cy = 0.0 * scale;
	float Dx = 160.0 * scale;
	float Dy = 0.0 * scale;
    float Ex = 160.0 * scale;
    float Ey = 250.0 * scale;
    */
    /*
    float Ax = 0.0 * scale;
	float Ay = 254.0 * scale;
	float Bx = -100.0 * scale;
	float By = 120.0 * scale;
	float Cx = 40.0 * scale;
	float Cy = 0.0 * scale;
	float Dx = 7.0 * scale;
	float Dy = 254.0 * scale;
    */
    float Ax = 0.0 * scale;
	float Ay = 0.0 * scale;
	float Bx = -100.0 * scale;
	float By = 130.0 * scale;
	float Cx = 40.0 * scale;
	float Cy = 250.0 * scale;
//	float Dx = 7.0 * scale;
//	float Dy = 0.0 * scale;
    
    // We need this mutable for now. We'll return this cast as non-mutable.
	CGMutablePathRef returnPathRef = CGPathCreateMutable();
    
    // Start
    CGPathMoveToPoint(returnPathRef, NULL, Ax, Ay);
    //Build triangle
    CGPathAddLineToPoint(returnPathRef, NULL, Bx, By);
    CGPathAddLineToPoint(returnPathRef, NULL, Cx, Cy);
    //CGPathAddLineToPoint(returnPathRef, NULL, Ax, Ay);
    //CGPathAddLineToPoint(returnPathRef, NULL, Dx, Dy);
    //CGPathAddLineToPoint(returnPathRef, NULL, Ex, Ey);
    
    CGPathCloseSubpath(returnPathRef);
    
    // Return the path as a plain CGPathRef
	return (CGPathRef)returnPathRef;

}
@end
