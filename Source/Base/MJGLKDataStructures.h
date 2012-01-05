//
//  MJGLKDataStructures.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <MJGLayoutKit/MJGLKBase.h>

#import <Foundation/Foundation.h>

#define MJGLKSizeFillParent  ((NSInteger)-1)
#define MJGLKSizeWrapContent ((NSInteger)-2)

/* Layout spec definition */

typedef struct {
    NSInteger width;
    NSInteger height;
    CGFloat weight;
    UIEdgeInsets margin;
    UIEdgeInsets padding;
} MJGLKLayoutSpec;

MJGLK_EXTERN const MJGLKLayoutSpec MJGLKLayoutSpecZero;

MJGLK_STATIC_INLINE MJGLKLayoutSpec MJGLKLayoutSpecMake(NSInteger width, NSInteger height, CGFloat weight, UIEdgeInsets margin, UIEdgeInsets padding) {
    MJGLKLayoutSpec layoutSpec;
    layoutSpec.width = width;
    layoutSpec.height = height;
    layoutSpec.weight = weight;
    layoutSpec.margin = margin;
    layoutSpec.padding = padding;
    return layoutSpec;
}

MJGLK_EXTERN NSString* NSStringFromMJGLKLayoutSpec(MJGLKLayoutSpec layoutSpec);


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

MJGLK_EXTERN const MJGLKDimension MJGLKDimensionZero;

MJGLK_STATIC_INLINE MJGLKDimension MJGLKDimensionMake(NSInteger size, MJGLKSizeConstraint constraint) {
    MJGLKDimension dimension;
    dimension.size = size;
    dimension.constraint = constraint;
    return dimension;
}

MJGLK_EXTERN NSString* NSStringFromMJGLKDimension(MJGLKDimension dimension);
MJGLK_EXTERN NSString* NSStringFromMJGLKDimension2D(MJGLKDimension2D dimensions);

MJGLK_EXTERN CGFloat ReconcileSizeWithDimension(CGFloat size, MJGLKDimension dimension);
