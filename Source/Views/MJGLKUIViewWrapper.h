//
//  MJGLKUIViewWrapper.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 04/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKView.h"
#import "MJGLKBase.h"

#import <UIKit/UIKit.h>

MJGLK_EXTERN
@interface MJGLKUIViewWrapper : MJGLKView

@property (nonatomic, strong) UIView *uiView;
@property (nonatomic, assign) CGSize contentSize;

- (id)initWithUIView:(UIView*)uiView;
- (id)initWithUIView:(UIView*)uiView contentSize:(CGSize)size;

@end
