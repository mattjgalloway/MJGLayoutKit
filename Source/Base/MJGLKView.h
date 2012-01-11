//
//  MJGLKView.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJGLKDataStructures.h"

@class MJGLKLayout;
@class MJGLKRootView;

@interface MJGLKView : NSObject

@property (nonatomic, assign) MJGLKLayoutSpec layoutSpec;

@property (nonatomic, assign) CGSize measuredSize;

@property (nonatomic, unsafe_unretained, readonly) MJGLKLayout *layout;
@property (nonatomic, unsafe_unretained, readonly) MJGLKRootView *rootView;

- (void)removeFromLayout;
- (void)setNeedsLayout;

- (void)updateViewWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height;

/**
 * Subclasses must implement the following methods
 */
- (UIView*)view;
- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height;
- (void)layoutView;

@end
