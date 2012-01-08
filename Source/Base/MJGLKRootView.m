//
//  MJGLKRootView.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 05/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKRootView.h"

#import "MJGLKLayout.h"
#import "MJGLKLayout+Private.h"

@interface MJGLKRootView ()
@property (nonatomic, strong, readwrite) MJGLKLayout *layout;
@end

@implementation MJGLKRootView

@synthesize layout = _layout;

#pragma mark -

- (id)initWithLayout:(MJGLKLayout*)inLayout {
    if ((self = [super initWithFrame:CGRectZero])) {
        self.layout = inLayout;
        self.layout.rootView = self;
        [self addSubview:self.layout.view];
    }
    return self;
}


#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    self.layout.view.frame = bounds;
    
    MJGLKDimension width = MJGLKDimensionMake((NSInteger)(bounds.size.width - self.layout.layoutSpec.margin.left - self.layout.layoutSpec.margin.right), MJGLKSizeConstraintExact);
    MJGLKDimension height = MJGLKDimensionMake((NSInteger)(bounds.size.height - self.layout.layoutSpec.margin.top - self.layout.layoutSpec.margin.bottom), MJGLKSizeConstraintExact);
    [self.layout updateViewWidth:width andHeight:height];
    
    [self.layout layoutView];
}

@end
