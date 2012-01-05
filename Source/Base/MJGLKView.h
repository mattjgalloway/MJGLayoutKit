//
//  MJGLKView.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJGLayoutKit/MJGLKBase.h>
#import <MJGLayoutKit/MJGLKDataStructures.h>

@class MJGLKLayout;

MJGLK_EXTERN
@interface MJGLKView : NSObject

@property (nonatomic, assign) MJGLKLayoutSpec layoutSpec;

@property (nonatomic, assign) CGSize measuredSize;

@property (nonatomic, unsafe_unretained, readonly) MJGLKLayout *layout;

- (void)removeFromLayout;
- (void)setNeedsLayout;

/**
 * Subclasses must implement the following methods
 */
@property (nonatomic, strong, readonly) UIView *view;
- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height;
- (void)layoutView;

@end
