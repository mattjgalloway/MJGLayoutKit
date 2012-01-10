//
//  MJGLKRootView.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file requires ARC to be enabled. Either enable ARC for the entire project or use -fobjc-arc flag.
#endif

#import "MJGLKRootView.h"

#import "MJGLKView.h"
#import "MJGLKView+Private.h"

@interface MJGLKRootView ()
@property (nonatomic, strong, readwrite) MJGLKView *view;
@end

@implementation MJGLKRootView

@synthesize view = _view;

#pragma mark -

- (id)initWithView:(MJGLKView*)inView {
    if ((self = [super initWithFrame:CGRectZero])) {
        self.view = inView;
        self.view.rootView = self;
        [self addSubview:self.view.view];
    }
    return self;
}


#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    MJGLKDimension width = MJGLKDimensionMake((NSInteger)(bounds.size.width - self.view.layoutSpec.margin.left - self.view.layoutSpec.margin.right), MJGLKSizeConstraintExact);
    MJGLKDimension height = MJGLKDimensionMake((NSInteger)(bounds.size.height - self.view.layoutSpec.margin.top - self.view.layoutSpec.margin.bottom), MJGLKSizeConstraintExact);
    [self.view updateViewWidth:width andHeight:height];
    
    self.view.view.frame = CGRectMake(0.0f, 0.0f, self.view.measuredSize.width, self.view.measuredSize.height);
    
    [self.view layoutView];
}

@end
