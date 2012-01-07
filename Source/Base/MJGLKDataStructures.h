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

typedef struct {
    NSInteger width;
    NSInteger height;
    CGFloat weight;
    UIEdgeInsets margin;
    UIEdgeInsets padding;
} MJGLKLayoutSpec;

extern const MJGLKLayoutSpec MJGLKLayoutSpecZero;

static inline MJGLKLayoutSpec MJGLKLayoutSpecMake(NSInteger width, NSInteger height, CGFloat weight, UIEdgeInsets margin, UIEdgeInsets padding) {
    MJGLKLayoutSpec layoutSpec;
    layoutSpec.width = width;
    layoutSpec.height = height;
    layoutSpec.weight = weight;
    layoutSpec.margin = margin;
    layoutSpec.padding = padding;
    return layoutSpec;
}

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

extern CGFloat ReconcileSizeWithDimension(CGFloat size, MJGLKDimension dimension);
