//
//  MJGLKLayout.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKView.h"

@class MJGLKRootView;

@interface MJGLKLayout : MJGLKView

@property (nonatomic, unsafe_unretained, readonly) MJGLKRootView *rootView;
@property (nonatomic, strong, readonly) NSArray *views;

- (id)initWithViews:(NSArray*)views;

- (void)addView:(MJGLKView*)view;
- (void)removeView:(MJGLKView*)view;

@end
