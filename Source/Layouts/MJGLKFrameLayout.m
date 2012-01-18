//
//  MJGLKFrameLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 06/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file requires ARC to be enabled. Either enable ARC for the entire project or use -fobjc-arc flag.
#endif

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
        
        [view updateViewWidth:childWidth andHeight:childHeight];
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
            
            [view updateViewWidth:childWidth andHeight:childHeight];
        }
    }
    
    maxWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
    maxHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
    
    self.measuredSize = CGSizeMake(maxWidth, maxHeight);
}

- (void)performLayoutView {
    for (MJGLKView *view in self.views) {
        MJGLKGravity childGravity = [self _resolveGravityFromParentGravity:self.layoutSpec.gravity andChildLayoutGravity:view.layoutSpec.layoutGravity];
        
        CGRect childFrame = CGRectZero;
        childFrame.size = CGSizeMake(view.measuredSize.width, view.measuredSize.height);
        
        MJGLKGravity childHorizontalGravity = childGravity & MJGLKGravityHorizontalMask;
        switch (childHorizontalGravity) {
            case MJGLKGravityLeft: {
                childFrame.origin.x = self.layoutSpec.padding.left + view.layoutSpec.margin.left;
            }
                break;
            case MJGLKGravityRight: {
                childFrame.origin.x = self.measuredSize.width - self.layoutSpec.padding.right - view.measuredSize.width - view.layoutSpec.margin.right;
            }
                break;
            case MJGLKGravityCenterHorizontal:
            case MJGLKGravityUnspecified:
            default: {
                childFrame.origin.x = (self.measuredSize.width - view.measuredSize.width) / 2.0f;
            }
                break;
        }
        
        MJGLKGravity childVerticalGravity = childGravity & MJGLKGravityVerticalMask;
        switch (childVerticalGravity) {
            case MJGLKGravityTop: {
                childFrame.origin.y = self.layoutSpec.padding.top + view.layoutSpec.margin.top;
            }
                break;
            case MJGLKGravityBottom: {
                childFrame.origin.y = self.measuredSize.height - self.layoutSpec.padding.bottom - view.measuredSize.height - view.layoutSpec.margin.bottom;
            }
                break;
            case MJGLKGravityCenterVertical:
            case MJGLKGravityUnspecified:
            default: {
                childFrame.origin.y = (self.measuredSize.height - view.measuredSize.height) / 2.0f;
            }
                break;
        }
        
        [self.view addSubview:view.view];
        [self.view bringSubviewToFront:view.view];
        view.view.frame = childFrame;
        [view layoutView];
    }
}

@end
