//
//  MJGLKDataStructures.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file requires ARC to be enabled. Either enable ARC for the entire project or use -fobjc-arc flag.
#endif

#import "MJGLKDataStructures.h"

const NSUInteger MJGLKGravityVerticalMask   = 0x0000000F;
const NSUInteger MJGLKGravityHorizontalMask = 0x000000F0;

const MJGLKLayoutSpec MJGLKLayoutSpecZero = {0, 0, 0.0f, {0.0f, 0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 0.0f, 0.0f}, 0, 0};

const MJGLKDimension MJGLKDimensionZero = {0, MJGLKSizeConstraintUnspecified};

extern NSString* NSStringFromMJGLKGravity(MJGLKGravity gravity) {
    NSMutableArray *components = [NSMutableArray arrayWithCapacity:0];
    if (gravity & MJGLKGravityTop) {
        [components addObject:@"TOP"];
    }
    if (gravity & MJGLKGravityBottom) {
        [components addObject:@"BOTTOM"];
    }
    if (gravity & MJGLKGravityCenterVertical) {
        [components addObject:@"CENTERVERTICAL"];
    }
    if (gravity & MJGLKGravityLeft) {
        [components addObject:@"LEFT"];
    }
    if (gravity & MJGLKGravityRight) {
        [components addObject:@"RIGHT"];
    }
    if (gravity & MJGLKGravityCenterHorizontal) {
        [components addObject:@"CENTERHORIZONTAL"];
    }
    return [components componentsJoinedByString:@"|"];
}

NSString* NSStringFromMJGLKLayoutSpec(MJGLKLayoutSpec layoutSpec) {
    return [NSString stringWithFormat:@"{%d,%d,%.2f,%@,%@,%@,%@}", layoutSpec.width, layoutSpec.height, layoutSpec.weight, NSStringFromUIEdgeInsets(layoutSpec.margin), NSStringFromUIEdgeInsets(layoutSpec.padding), NSStringFromMJGLKGravity(layoutSpec.layoutGravity), NSStringFromMJGLKGravity(layoutSpec.gravity)];
}

NSString* NSStringFromMJGLKDimension(MJGLKDimension dimension) {
    NSString *constraintString = nil;
    switch (dimension.constraint) {
        case MJGLKSizeConstraintExact:
            constraintString = @"EXACT";
            break;
        case MJGLKSizeConstraintMaximum:
            constraintString = @"MAXIMUM";
            break;
        case MJGLKSizeConstraintUnspecified:
            constraintString = @"UNSPECIFIED";
            break;
    }
    
    return [NSString stringWithFormat:@"{%d,%@}", dimension.size, constraintString];
}

NSString* NSStringFromMJGLKDimension2D(MJGLKDimension2D dimensions) {
    return [NSString stringWithFormat:@"{%@,%@}", NSStringFromMJGLKDimension(dimensions.width), NSStringFromMJGLKDimension(dimensions.height)];
}

BOOL MJGLKDimensionEqual(MJGLKDimension lhs, MJGLKDimension rhs) {
    if (lhs.size == rhs.size && 
        lhs.constraint == rhs.constraint)
    {
        return YES;
    }
    return NO;
}

CGFloat ReconcileSizeWithDimension(CGFloat size, MJGLKDimension dimension) {
    CGFloat retSize = size;
    switch (dimension.constraint) {
        case MJGLKSizeConstraintExact:
            retSize = (CGFloat)(dimension.size);
            break;
        case MJGLKSizeConstraintMaximum:
            retSize = MIN(size, (CGFloat)(dimension.size));
            break;
        case MJGLKSizeConstraintUnspecified:
            // That's fine
            break;
    }
    return retSize;
}
