//
//  MJGLKView+Private.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKView.h"

@class MJGLKLayout;

@interface MJGLKView (Private)

@property (nonatomic, unsafe_unretained, readwrite) MJGLKLayout *layout;

@end
