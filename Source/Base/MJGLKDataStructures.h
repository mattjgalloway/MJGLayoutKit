//
//  MJGLKDataStructures.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MJGLKSizeFillParent  ((NSInteger)-1)
#define MJGLKSizeWrapContent ((NSInteger)-2)

/* Layout spec definition */

enum {
    MJGLKGravityUnspecified      = 0,
    MJGLKGravityTop              = 1 << 0,
    MJGLKGravityBottom           = 1 << 1,
    MJGLKGravityCenterVertical   = 1 << 2,
    MJGLKGravityLeft             = 1 << 4,
    MJGLKGravityRight            = 1 << 5,
    MJGLKGravityCenterHorizontal = 1 << 6,
    MJGLKGravityCenter           = MJGLKGravityCenterVertical | MJGLKGravityCenterHorizontal,
};
typedef NSUInteger MJGLKGravity;

extern const NSUInteger MJGLKGravityVerticalMask;
extern const NSUInteger MJGLKGravityHorizontalMask;

typedef struct {
    NSInteger width;
    NSInteger height;
    CGFloat weight;
    UIEdgeInsets margin;
    UIEdgeInsets padding;
    MJGLKGravity layoutGravity;
    MJGLKGravity gravity;
} MJGLKLayoutSpec;

extern const MJGLKLayoutSpec MJGLKLayoutSpecZero;

static inline MJGLKLayoutSpec MJGLKLayoutSpecMake(NSInteger width, NSInteger height, CGFloat weight, UIEdgeInsets margin, UIEdgeInsets padding, MJGLKGravity layoutGravity, MJGLKGravity gravity) {
    MJGLKLayoutSpec layoutSpec;
    layoutSpec.width = width;
    layoutSpec.height = height;
    layoutSpec.weight = weight;
    layoutSpec.margin = margin;
    layoutSpec.padding = padding;
    layoutSpec.layoutGravity = layoutGravity;
    layoutSpec.gravity = gravity;
    return layoutSpec;
}

extern NSString* NSStringFromMJGLKGravity(MJGLKGravity gravity);
extern NSString* NSStringFromMJGLKLayoutSpec(MJGLKLayoutSpec layoutSpec);


/* Dimension constraint types */

typedef enum {
    MJGLKSizeConstraintUnspecified = 0,
    MJGLKSizeConstraintMaximum,
    MJGLKSizeConstraintExact,
} MJGLKSizeConstraint;


/* Dimension definition */

typedef struct {
    NSInteger size;
    MJGLKSizeConstraint constraint;
} MJGLKDimension;

typedef struct {
    MJGLKDimension width;
    MJGLKDimension height;
} MJGLKDimension2D;

extern const MJGLKDimension MJGLKDimensionZero;

static inline MJGLKDimension MJGLKDimensionMake(NSInteger size, MJGLKSizeConstraint constraint) {
    MJGLKDimension dimension;
    dimension.size = size;
    dimension.constraint = constraint;
    return dimension;
}

extern NSString* NSStringFromMJGLKDimension(MJGLKDimension dimension);
extern NSString* NSStringFromMJGLKDimension2D(MJGLKDimension2D dimensions);

extern BOOL MJGLKDimensionEqual(MJGLKDimension lhs, MJGLKDimension rhs);

extern CGFloat ReconcileSizeWithDimension(CGFloat size, MJGLKDimension dimension);
