//
//  MJGLKRootView.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJGLKView;

@interface MJGLKRootView : UIView

@property (nonatomic, strong, readonly) MJGLKView *view;

- (id)initWithView:(MJGLKView*)view;

- (void)reflowLayout;

@end
