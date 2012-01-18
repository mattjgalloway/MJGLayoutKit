//
//  MJGLKLayout+Private.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLayout.h"

#import "MJGLKDataStructures.h"

@class MJGLKRootView;

@interface MJGLKLayout (Private)

- (MJGLKDimension)_childDimensionFromParentDimension:(MJGLKDimension)parentDimension withPadding:(NSInteger)padding withChildSize:(NSInteger)childSize;
- (MJGLKGravity)_resolveGravityFromParentGravity:(MJGLKGravity)parentGravity andChildLayoutGravity:(MJGLKGravity)childLayoutGravity;

@end
