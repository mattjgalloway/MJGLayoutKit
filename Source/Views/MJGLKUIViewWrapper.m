//
//  MJGLKUIViewWrapper.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 04/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKUIViewWrapper.h"

@interface MJGLKUIViewWrapper ()
@end

@implementation MJGLKUIViewWrapper

@synthesize uiView = _uiView;
@synthesize contentSize = _contentSize;

#pragma mark -

- (id)initWithUIView:(UIView*)inUiView {
    if ((self = [self initWithUIView:inUiView contentSize:inUiView.bounds.size])) {
    }
    return self;
}

- (id)initWithUIView:(UIView*)inUiView contentSize:(CGSize)inSize {
    if ((self = [super init])) {
        self.uiView = inUiView;
        self.uiView.autoresizingMask = UIViewAutoresizingNone;
        self.contentSize = inSize;
    }
    return self;
}


#pragma mark - Custom accessors

- (void)setUiView:(UIView*)inUiView {
    _uiView = inUiView;
}

- (void)setContentSize:(CGSize)inContentSize {
    _contentSize = inContentSize;
}


#pragma mark -

- (UIView*)view {
    return self.uiView;
}

- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height {
    CGSize newMeasuredSize = CGSizeZero;
    
    switch (width.constraint) {
        case MJGLKSizeConstraintExact:
            newMeasuredSize.width = (CGFloat)width.size;
            break;
        case MJGLKSizeConstraintMaximum:
            newMeasuredSize.width = MIN(self.contentSize.width, (CGFloat)(width.size));
            break;
        case MJGLKSizeConstraintUnspecified:
            newMeasuredSize.width = self.contentSize.width;
            break;
    }
    
    switch (height.constraint) {
        case MJGLKSizeConstraintExact:
            newMeasuredSize.height = (CGFloat)height.size;
            break;
        case MJGLKSizeConstraintMaximum:
            newMeasuredSize.height = MIN(self.contentSize.height, (CGFloat)(height.size));
            break;
        case MJGLKSizeConstraintUnspecified:
            newMeasuredSize.height = self.contentSize.height;
            break;
    }
    
    self.measuredSize = newMeasuredSize;
}

- (void)layoutView {
}

@end
