//
//  MJGLKLayout+Private.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLayout+Private.h"

@implementation MJGLKLayout (Private)

@dynamic rootView;

- (MJGLKDimension)childDimensionFromParentDimension:(MJGLKDimension)parentDimension withPadding:(NSInteger)padding withChildSize:(NSInteger)childSize {
    NSInteger size = 0;
    MJGLKSizeConstraint constraint = MJGLKSizeConstraintUnspecified;
    
    NSInteger parentSizeMinusPadding = MAX(0, parentDimension.size - padding);
    
    switch (parentDimension.constraint) {
        case MJGLKSizeConstraintExact:
            if (childSize >= 0) {
                size = childSize;
                constraint = MJGLKSizeConstraintExact;
            } else if (childSize == MJGLKSizeFillParent) {
                size = parentSizeMinusPadding;
                constraint = MJGLKSizeConstraintExact;
            } else if (childSize == MJGLKSizeWrapContent) {
                size = parentSizeMinusPadding;
                constraint = MJGLKSizeConstraintMaximum;
            } else {
                // Well, something went wrong then!
            }
            break;
        case MJGLKSizeConstraintMaximum:
            if (childSize >= 0) {
                size = childSize;
                constraint = MJGLKSizeConstraintExact;
            } else if (childSize == MJGLKSizeFillParent) {
                size = parentSizeMinusPadding;
                constraint = MJGLKSizeConstraintMaximum;
            } else if (childSize == MJGLKSizeWrapContent) {
                size = parentSizeMinusPadding;
                constraint = MJGLKSizeConstraintMaximum;
            } else {
                // Well, something went wrong then!
            }
            break;
        case MJGLKSizeConstraintUnspecified:
            if (childSize >= 0) {
                size = childSize;
                constraint = MJGLKSizeConstraintExact;
            } else if (childSize == MJGLKSizeFillParent) {
                size = 0;
                constraint = MJGLKSizeConstraintUnspecified;
            } else if (childSize == MJGLKSizeWrapContent) {
                size = 0;
                constraint = MJGLKSizeConstraintUnspecified;
            } else {
                // Well, something went wrong then!
            }
            break;
    }
    
    return MJGLKDimensionMake(size, constraint);
}

@end
