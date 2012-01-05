//
//  MJGLKDataStructures.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKDataStructures.h"

const MJGLKLayoutSpec MJGLKLayoutSpecZero = {0, 0, 0.0f, {0.0f, 0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 0.0f, 0.0f}};

const MJGLKDimension MJGLKDimensionZero = {0, MJGLKSizeConstraintUnspecified};

NSString* NSStringFromMJGLKLayoutSpec(MJGLKLayoutSpec layoutSpec) {
    return [NSString stringWithFormat:@"{%d,%d,%.2f,%@,%@}", layoutSpec.width, layoutSpec.height, layoutSpec.weight, NSStringFromUIEdgeInsets(layoutSpec.margin), NSStringFromUIEdgeInsets(layoutSpec.padding)];
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
