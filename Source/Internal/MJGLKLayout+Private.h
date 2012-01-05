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

@property (nonatomic, unsafe_unretained, readwrite) MJGLKRootView *rootView;

- (MJGLKDimension)childDimensionFromParentDimension:(MJGLKDimension)parentDimension withPadding:(NSInteger)padding withChildSize:(NSInteger)childSize;

@end
