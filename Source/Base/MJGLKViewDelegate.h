//
//  MJGLKViewDelegate.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 11/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJGLKView;

@protocol MJGLKViewDelegate <NSObject>
@optional
- (void)lkViewWillMeasureView:(MJGLKView*)view;
- (void)lkViewDidMeasureView:(MJGLKView*)view;
- (void)lkViewWillLayoutView:(MJGLKView*)view;
- (void)lkViewDidLayoutView:(MJGLKView*)view;
@end
