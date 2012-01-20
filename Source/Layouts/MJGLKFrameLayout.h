//
//  MJGLKFrameLayout.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLayout.h"

@interface MJGLKFrameLayout : MJGLKLayout

@property (nonatomic, strong) UIColor *backgroundColor;

- (id)initWithViews:(NSArray*)views;

@end
