//
//  ShapeUtilities.m
//
//  Created by Jeff Menter on 4/20/11.
//  Copyright 2011 Jeff Menter. No rights reserved.
//
/* This class creates a CGPathRef from an NSString. This NSString contains a special chunk of an Illustrator 3 EPS.
 Open the EPS file in your favorite text editor. Find this:
 ... (beginning something)
 %%EndSetup
 ... (middle something)
 %%PageTrailer
 ... (ending something)

 Copy and paste that middle something straight into an NSString or read it in from a saved file. The points and commands will be turned into a CGPathRef. Neato!
 Note: we don't do any error checking so be careful. Also, we don't deal with anything even remotely fancy like fill colors or stroke weights, etc. Just the simple path data. Wanna make it better?
 */

#import "ShapeUtilities.h"


@implementation ShapeUtilities

- (id)init
{
    self = [super init];
    if (self) {
        // No init stuff needed.
    }
    
    return self;
}

+ (CGPathRef)createCGPathRefFromEPSString:(NSString *)epsString {
	// Declare some floats for the incoming point data.
	float currentPoint_x = 0.0;
	float currentPoint_y = 0.0;
	float controlPoint1_x = 0.0;
	float controlPoint1_y = 0.0;
	float controlPoint2_x = 0.0;
	float controlPoint2_y = 0.0;
	float previousPoint_x = 0.0;
	float previousPoint_y = 0.0;
	
	// These are the markers used in the EPS chunk. We create a NSCharacterSet to use with the NSScanners.
	NSCharacterSet *pathPointMarkers = [NSCharacterSet characterSetWithCharactersInString:@"mMcCvVlLyYfF"];
	
	// This scanner scans the totality of the incoming string.
	NSScanner *epsStringScanner = [NSScanner scannerWithString:epsString];
	
	// Needed for the marker to marker substrings.
	NSString *pointSubString;
	// Need a NSScanner as well.
	NSScanner *pointSubStringScanner;
	// We need this mutable for now. We'll return this cast as non-mutable.
	CGMutablePathRef returnPathRef = CGPathCreateMutable();
	
	// Go through the string character by character till we reach the end.
	while ([epsStringScanner isAtEnd] == NO) {
		// Scan up to a marker and put that chunk in a substring.
		[epsStringScanner scanUpToCharactersFromSet:pathPointMarkers intoString:&pointSubString];
		// Scanner for the substring.
		pointSubStringScanner = [NSScanner scannerWithString:pointSubString];
		
		// Check to see what kind of marker we've found.
		// m or M is moveToPoint.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'm' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'M') {
			// Get the two floats we expect for this marker and assign them.
			[pointSubStringScanner scanFloat:&currentPoint_x];
			[pointSubStringScanner scanFloat:&currentPoint_y];
			// Execute the proper CGPath operation.
			CGPathMoveToPoint(returnPathRef, NULL, currentPoint_x, currentPoint_y);
		}
		// c or C is "curve from and to" with a control point from the previous point.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'c' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'C') {
			// Get the six floats we expect.
			[pointSubStringScanner scanFloat:&controlPoint1_x];
			[pointSubStringScanner scanFloat:&controlPoint1_y];
			[pointSubStringScanner scanFloat:&controlPoint2_x];
			[pointSubStringScanner scanFloat:&controlPoint2_y];
			[pointSubStringScanner scanFloat:&currentPoint_x];
			[pointSubStringScanner scanFloat:&currentPoint_y];
			// Do it up.
			CGPathAddCurveToPoint(returnPathRef, NULL, controlPoint1_x, controlPoint1_y, controlPoint2_x, controlPoint2_y, currentPoint_x, currentPoint_y);
		}
		// v or V is "curve to only". No handle from the point we came from.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'v' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'V') {
			// Since there is no handle from the point we came from, we just assign the previous
			// control point's coordinates.
			[pointSubStringScanner scanFloat:&controlPoint1_x];
			[pointSubStringScanner scanFloat:&controlPoint1_y];
			[pointSubStringScanner scanFloat:&currentPoint_x];
			[pointSubStringScanner scanFloat:&currentPoint_y];
			// Make it so.
			CGPathAddCurveToPoint(returnPathRef, NULL, previousPoint_x, previousPoint_y, controlPoint1_x, controlPoint1_y, currentPoint_x, currentPoint_y);
		}
		// y or Y is "curve from only". No handle on the point we're going to.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'y' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'Y') {
			[pointSubStringScanner scanFloat:&controlPoint1_x];
			[pointSubStringScanner scanFloat:&controlPoint1_y];
			[pointSubStringScanner scanFloat:&currentPoint_x];
			[pointSubStringScanner scanFloat:&currentPoint_y];
			// Aw yeah.
			CGPathAddCurveToPoint(returnPathRef, NULL, controlPoint1_x, controlPoint1_y, currentPoint_x, currentPoint_y, currentPoint_x, currentPoint_y);
		}
		// l or L is "line to point". Simple.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'l' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'L') {
			[pointSubStringScanner scanFloat:&currentPoint_x];
			[pointSubStringScanner scanFloat:&currentPoint_y];
			// Totally appropriate.
			CGPathAddLineToPoint(returnPathRef, NULL, currentPoint_x, currentPoint_y);
		}
		// f or F is "close this subpath and start a new one." When you're drawing the resulting
		// path, use even-odd fill rules to make compound paths appear as you would expect.
		if ([epsString characterAtIndex:[epsStringScanner scanLocation]] == 'f' ||
			[epsString characterAtIndex:[epsStringScanner scanLocation]] == 'F') {
			CGPathCloseSubpath(returnPathRef);
		}
		// Assign these in case we get one of those whacky "curve to only" commands next time through.
		previousPoint_x = currentPoint_x;
		previousPoint_y = currentPoint_y;
		// Put the scan location of the scanner one character ahead so it will continue on.
		[epsStringScanner setScanLocation:[epsStringScanner scanLocation] + 1];
	}
	// Return the path as a plain CGPathRef. I don't see why not?
	return (CGPathRef)returnPathRef;
}

- (void)dealloc
{
    [super dealloc];
}

@end
