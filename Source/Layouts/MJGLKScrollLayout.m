//
//  MJGLKScrollLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 07/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file requires ARC to be enabled. Either enable ARC for the entire project or use -fobjc-arc flag.
#endif

#import "MJGLKScrollLayout.h"

#import "MJGLKLayout+Private.h"

@interface MJGLKScrollLayout ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) MJGLKView *scrolledView;
@end

@implementation MJGLKScrollLayout

@synthesize scrollView = _scrollView;

#pragma mark -

- (id)initWithView:(MJGLKView*)inView {
    if ((self = [super initWithViews:[NSArray arrayWithObject:inView]])) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollView.autoresizingMask = UIViewAutoresizingNone;
        self.scrollView.scrollEnabled = YES;
    }
    return self;
}
                 
                 
#pragma mark - Custom accessors

- (MJGLKView*)scrolledView {
    return [self.views objectAtIndex:0];
}


#pragma mark -

- (UIView*)view {
    return self.scrollView;
}

- (void)measureViewWithWidth:(MJGLKDimension)width andHeight:(MJGLKDimension)height {
    CGFloat contentWidth = 0.0f;
    CGFloat contentHeight = 0.0f;
    
    MJGLKDimension childWidth = [self _childDimensionFromParentDimension:width 
                                                             withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + self.scrolledView.layoutSpec.margin.left + self.scrolledView.layoutSpec.margin.right) 
                                                           withChildSize:self.scrolledView.layoutSpec.width];
    MJGLKDimension childHeight = [self _childDimensionFromParentDimension:height 
                                                              withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + self.scrolledView.layoutSpec.margin.top + self.scrolledView.layoutSpec.margin.bottom) 
                                                            withChildSize:self.scrolledView.layoutSpec.height];
    
    [self.scrolledView updateViewWidth:childWidth andHeight:childHeight];
    contentWidth = self.scrolledView.measuredSize.width + self.scrolledView.layoutSpec.margin.left + self.scrolledView.layoutSpec.margin.right;
    contentHeight = self.scrolledView.measuredSize.height + self.scrolledView.layoutSpec.margin.top + self.scrolledView.layoutSpec.margin.bottom;
    
    if (self.scrolledView.layoutSpec.width == MJGLKSizeFillParent || self.scrolledView.layoutSpec.height == MJGLKSizeFillParent) {
        MJGLKDimension childWidth;
        if (self.scrolledView.layoutSpec.width == MJGLKSizeFillParent) {
            childWidth = MJGLKDimensionMake(contentWidth, MJGLKSizeConstraintExact);
        } else {
            childWidth = [self _childDimensionFromParentDimension:width 
                                                      withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + self.scrolledView.layoutSpec.margin.left + self.scrolledView.layoutSpec.margin.right) 
                                                    withChildSize:self.scrolledView.layoutSpec.width];
        }
        
        MJGLKDimension childHeight;
        if (self.scrolledView.layoutSpec.width == MJGLKSizeFillParent) {
            childHeight = MJGLKDimensionMake(contentHeight, MJGLKSizeConstraintExact);
        } else {
            childHeight = [self _childDimensionFromParentDimension:height 
                                                       withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + self.scrolledView.layoutSpec.margin.top + self.scrolledView.layoutSpec.margin.bottom) 
                                                     withChildSize:self.scrolledView.layoutSpec.height];
        }
        
        [self.scrolledView updateViewWidth:childWidth andHeight:childHeight];
    }
    
    contentWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
    contentHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    CGSize newMeasuredSize = CGSizeZero;
    
    switch (width.constraint) {
        case MJGLKSizeConstraintExact:
            newMeasuredSize.width = (CGFloat)width.size;
            break;
        case MJGLKSizeConstraintMaximum:
            newMeasuredSize.width = MIN(contentWidth, (CGFloat)(width.size));
            break;
        case MJGLKSizeConstraintUnspecified:
            newMeasuredSize.width = contentWidth;
            break;
    }
    
    switch (height.constraint) {
        case MJGLKSizeConstraintExact:
            newMeasuredSize.height = (CGFloat)height.size;
            break;
        case MJGLKSizeConstraintMaximum:
            newMeasuredSize.height = MIN(contentHeight, (CGFloat)(height.size));
            break;
        case MJGLKSizeConstraintUnspecified:
            newMeasuredSize.height = contentHeight;
            break;
    }
    
    self.measuredSize = newMeasuredSize;
}

- (void)layoutView {
    [self.scrollView addSubview:self.scrolledView.view];
    self.scrolledView.view.frame = CGRectMake(0.0f, 
                                              0.0f, 
                                              self.scrolledView.measuredSize.width, 
                                              self.scrolledView.measuredSize.height);
    [self.scrolledView layoutView];
}

@end
