//
//  MJGLKRootView.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJGLKLayout;

@interface MJGLKRootView : UIView

@property (nonatomic, strong, readonly) MJGLKLayout *layout;

- (id)initWithLayout:(MJGLKLayout*)layout;

@end
