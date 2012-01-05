//
//  MJGLKLinearLayout.h
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLayout.h"

#import <MJGLayoutKit/MJGLKBase.h>

typedef enum {
    MJGLKLinearLayoutOrientationHorizontal = 1,
    MJGLKLinearLayoutOrientationVertical,
} MJGLKLinearLayoutOrientation;

MJGLK_EXTERN
@interface MJGLKLinearLayout : MJGLKLayout

@property (nonatomic, assign, readonly) MJGLKLinearLayoutOrientation orientation;

- (id)initWithOrientation:(MJGLKLinearLayoutOrientation)orientation views:(NSArray*)views;

@end
