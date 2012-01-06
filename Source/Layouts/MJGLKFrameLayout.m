//
//  MJGLKFrameLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 06/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKFrameLayout.h"

#import "MJGLKLayout+Private.h"

@interface MJGLKFrameLayout ()
@property (nonatomic, strong) UIView *wrapperView;
@end

@implementation MJGLKFrameLayout

@synthesize wrapperView = _wrapperView;

#pragma mark -

- (id)initWithViews:(NSArray *)views {
    if ((self = [super initWithViews:views])) {
        self.wrapperView = [[UIView alloc] initWithFrame:CGRectZero];
        self.wrapperView.backgroundColor = [UIColor clearColor];
        self.wrapperView.opaque = NO;
    }
    return self;
}


#pragma mark -

- (UIView*)view {
    return self.wrapperView;
}

- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height {
    CGFloat maxWidth = 0.0f;
    CGFloat maxHeight = 0.0f;
    
    for (MJGLKView *view in self.views) {
        MJGLKDimension childWidth = [self _childDimensionFromParentDimension:width 
                                                                 withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + view.layoutSpec.margin.left + view.layoutSpec.margin.right) 
                                                               withChildSize:view.layoutSpec.width];
        MJGLKDimension childHeight = [self _childDimensionFromParentDimension:height 
                                                                  withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom) 
                                                                withChildSize:view.layoutSpec.height];
        
        [view measureViewWithWidth:childWidth andHeight:childHeight];
        maxHeight = MAX(maxHeight, view.measuredSize.height + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom);
        maxWidth = MAX(maxWidth, view.measuredSize.width + view.layoutSpec.margin.left + view.layoutSpec.margin.right);
    }
    
    for (MJGLKView *view in self.views) {
        if (view.layoutSpec.width == MJGLKSizeFillParent || view.layoutSpec.height == MJGLKSizeFillParent) {
            MJGLKDimension childWidth;
            if (view.layoutSpec.width == MJGLKSizeFillParent) {
                childWidth = MJGLKDimensionMake(maxWidth, MJGLKSizeConstraintExact);
            } else {
                childWidth = [self _childDimensionFromParentDimension:width 
                                                          withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + view.layoutSpec.margin.left + view.layoutSpec.margin.right) 
                                                        withChildSize:view.layoutSpec.width];
            }
            
            MJGLKDimension childHeight;
            if (view.layoutSpec.width == MJGLKSizeFillParent) {
                childHeight = MJGLKDimensionMake(maxHeight, MJGLKSizeConstraintExact);
            } else {
                childHeight = [self _childDimensionFromParentDimension:height 
                                                           withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom) 
                                                         withChildSize:view.layoutSpec.height];
            }
            
            [view measureViewWithWidth:childWidth andHeight:childHeight];
        }
    }
    
    maxWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
    maxHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
    
    self.measuredSize = CGSizeMake(maxWidth, maxHeight);
}

- (void)layoutView {
    for (MJGLKView *view in self.views) {
        [self.view addSubview:view.view];
        [self.view bringSubviewToFront:view.view];
        view.view.frame = CGRectMake(0.0f, 
                                     0.0f, 
                                     view.measuredSize.width, 
                                     view.measuredSize.height);
        view.view.center = CGPointMake(floorf(self.measuredSize.width / 2.0f), floorf(self.measuredSize.height / 2.0f));
        [view layoutView];
    }
}

@end
