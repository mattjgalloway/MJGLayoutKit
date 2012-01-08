//
//  MJGLKView.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKView.h"

#import "MJGLKLayout.h"

@interface MJGLKView ()
@property (nonatomic, unsafe_unretained, readwrite) MJGLKLayout *layout;
@property (nonatomic, assign) MJGLKDimension lastWidth;
@property (nonatomic, assign) MJGLKDimension lastHeight;
@property (nonatomic, assign) BOOL forceLayout;
@end

@implementation MJGLKView

@synthesize layoutSpec = _layoutSpec;
@synthesize measuredSize = _measuredSize;
@synthesize layout = _layout;
@synthesize lastWidth = _lastWidth;
@synthesize lastHeight = _lastHeight;
@synthesize forceLayout = _forceLayout;

#pragma mark -

- (id)init {
    if ((self = [super init])) {
        _layoutSpec = MJGLKLayoutSpecZero;
        _measuredSize = CGSizeZero;
        _lastWidth = MJGLKDimensionZero;
        _lastHeight = MJGLKDimensionZero;
        _forceLayout = YES;
    }
    return self;
}


#pragma mark -

- (void)removeFromLayout {
    [self.layout removeView:self];
}

- (void)setNeedsLayout {
    _forceLayout = YES;
    [self.layout setNeedsLayout];
}


#pragma mark -

- (void)updateViewWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height {
    if (_forceLayout || !MJGLKDimensionEqual(width, _lastWidth) || !MJGLKDimensionEqual(height, _lastHeight)) {
        [self measureViewWithWidth:width andHeight:height];
    }
    _lastWidth = width;
    _lastHeight = height;
    _forceLayout = NO;
}


#pragma mark -

- (UIView*)view {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                   reason:[NSString stringWithFormat:@"Subclasses must override %@.", NSStringFromSelector(_cmd)] 
                                 userInfo:nil];
}

- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                   reason:[NSString stringWithFormat:@"Subclasses must override %@.", NSStringFromSelector(_cmd)] 
                                 userInfo:nil];
}

- (void)layoutView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                   reason:[NSString stringWithFormat:@"Subclasses must override %@.", NSStringFromSelector(_cmd)] 
                                 userInfo:nil];
}

@end
