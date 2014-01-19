//
//  ShapeUtilities.h
//
//  Created by Jeff Menter on 4/20/11.
//  Copyright 2011 Jeff Menter. No rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShapeUtilities : NSObject {
    
}

+ (CGPathRef)createCGPathRefFromEPSString:(NSString *)epsString;

@end
