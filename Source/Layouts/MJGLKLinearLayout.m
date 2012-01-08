//
//  MJGLKLinearLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLinearLayout.h"

#import "MJGLKLayout+Private.h"

@interface MJGLKLinearLayout ()
@property (nonatomic, assign, readwrite) MJGLKLinearLayoutOrientation orientation;

@property (nonatomic, strong) UIView *wrapperView;
@end

@implementation MJGLKLinearLayout

@synthesize orientation = _orientation;
@synthesize wrapperView = _wrapperView;

#pragma mark -

- (id)initWithOrientation:(MJGLKLinearLayoutOrientation)inOrientation views:(NSArray *)views {
    if ((self = [super initWithViews:views])) {
        self.orientation = inOrientation;
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
    if (_orientation == MJGLKLinearLayoutOrientationVertical) {
        CGFloat totalHeight = 0.0f;
        CGFloat maxWidth = 0.0f;
        CGFloat totalWeight = 0.0f;
        
        for (MJGLKView *view in self.views) {
            if (view.layoutSpec.weight > 0.0f) {
                totalWeight += view.layoutSpec.weight;
            }
            
            MJGLKDimension childWidth = [self _childDimensionFromParentDimension:width 
                                                                     withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + view.layoutSpec.margin.left + view.layoutSpec.margin.right) 
                                                                   withChildSize:view.layoutSpec.width];
            MJGLKDimension childHeight = [self _childDimensionFromParentDimension:height 
                                                                      withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom) 
                                                                    withChildSize:view.layoutSpec.height];
            
            [view updateViewWidth:childWidth andHeight:childHeight];
            totalHeight += (view.layoutSpec.margin.top + view.measuredSize.height + view.layoutSpec.margin.bottom);
            
            maxWidth = MAX(maxWidth, view.measuredSize.width + view.layoutSpec.margin.left + view.layoutSpec.margin.right);
        }
        
        totalHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
        
        CGFloat actualHeight = totalHeight;
        actualHeight = ReconcileSizeWithDimension(actualHeight, height);
        
        CGFloat delta = actualHeight - totalHeight;
        if (delta != 0.0f && totalWeight > 0.0f) {
            totalHeight = 0.0f;
            
            // There's some views that can take some extra height
            for (MJGLKView *view in self.views) {
                if (view.layoutSpec.weight > 0) {
                    CGFloat thisShare = floorf(((view.layoutSpec.weight * delta) / totalWeight));
                    
                    MJGLKDimension childWidth = [self _childDimensionFromParentDimension:width 
                                                                             withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + view.layoutSpec.margin.left + view.layoutSpec.margin.right) 
                                                                           withChildSize:view.layoutSpec.width];
                    MJGLKDimension childHeight = MJGLKDimensionMake((NSInteger)(view.measuredSize.height + thisShare), MJGLKSizeConstraintExact);
                    [view updateViewWidth:childWidth andHeight:childHeight];
                }
                
                totalHeight += (view.layoutSpec.margin.top + view.measuredSize.height + view.layoutSpec.margin.bottom);
                
                maxWidth = MAX(maxWidth, view.measuredSize.width + view.layoutSpec.margin.left + view.layoutSpec.margin.right);
            }
            
            totalHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
        }
        
        if (width.constraint != MJGLKSizeConstraintExact) {
            for (MJGLKView *view in self.views) {
                if (view.layoutSpec.width == MJGLKSizeFillParent) {
                    MJGLKDimension childWidth = MJGLKDimensionMake(maxWidth - view.layoutSpec.margin.left - view.layoutSpec.margin.right, MJGLKSizeConstraintExact);
                    MJGLKDimension childHeight = MJGLKDimensionMake((NSInteger)(view.measuredSize.height), MJGLKSizeConstraintExact);
                    [view updateViewWidth:childWidth andHeight:childHeight];
                }
            }
        }
        
        maxWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
        
        self.measuredSize = CGSizeMake(maxWidth, totalHeight);
    } else {
        CGFloat totalWidth = 0.0f;
        CGFloat maxHeight = 0.0f;
        CGFloat totalWeight = 0.0f;
        
        for (MJGLKView *view in self.views) {
            if (view.layoutSpec.weight > 0.0f) {
                totalWeight += view.layoutSpec.weight;
            }
            
            MJGLKDimension childWidth = [self _childDimensionFromParentDimension:width 
                                                                     withPadding:(self.layoutSpec.padding.left + self.layoutSpec.padding.right + view.layoutSpec.margin.left + view.layoutSpec.margin.right) 
                                                                   withChildSize:view.layoutSpec.width];
            MJGLKDimension childHeight = [self _childDimensionFromParentDimension:height 
                                                                      withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom) 
                                                                    withChildSize:view.layoutSpec.height];
            
            [view updateViewWidth:childWidth andHeight:childHeight];
            totalWidth += (view.layoutSpec.margin.left + view.measuredSize.width + view.layoutSpec.margin.right);
            
            maxHeight = MAX(maxHeight, view.measuredSize.height + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom);
        }
        
        totalWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
        
        CGFloat actualWidth = totalWidth;
        actualWidth = ReconcileSizeWithDimension(actualWidth, width);
        
        CGFloat delta = actualWidth - totalWidth;
        if (delta != 0.0f && totalWeight > 0.0f) {
            totalWidth = 0.0f;
            
            // There's some views that can take some extra height
            for (MJGLKView *view in self.views) {
                if (view.layoutSpec.weight > 0) {
                    CGFloat thisShare = floorf(((view.layoutSpec.weight * delta) / totalWeight));
                    
                    MJGLKDimension childHeight = [self _childDimensionFromParentDimension:height 
                                                                              withPadding:(self.layoutSpec.padding.top + self.layoutSpec.padding.bottom + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom) 
                                                                            withChildSize:view.layoutSpec.height];
                    MJGLKDimension childWidth = MJGLKDimensionMake((NSInteger)(view.measuredSize.width + thisShare), MJGLKSizeConstraintExact);
                    [view updateViewWidth:childWidth andHeight:childHeight];
                }
                
                totalWidth += (view.layoutSpec.margin.left + view.measuredSize.width + view.layoutSpec.margin.right);
                
                maxHeight = MAX(maxHeight, view.measuredSize.height + view.layoutSpec.margin.top + view.layoutSpec.margin.bottom);
            }
            
            totalWidth += (self.layoutSpec.padding.left + self.layoutSpec.padding.right);
        }
        
        if (height.constraint != MJGLKSizeConstraintExact) {
            for (MJGLKView *view in self.views) {
                if (view.layoutSpec.height == MJGLKSizeFillParent) {
                    MJGLKDimension childWidth = MJGLKDimensionMake((NSInteger)(view.measuredSize.width), MJGLKSizeConstraintExact);
                    MJGLKDimension childHeight = MJGLKDimensionMake(maxHeight - view.layoutSpec.margin.top - view.layoutSpec.margin.bottom, MJGLKSizeConstraintExact);
                    [view updateViewWidth:childWidth andHeight:childHeight];
                }
            }
        }
        
        maxHeight += (self.layoutSpec.padding.top + self.layoutSpec.padding.bottom);
        
        self.measuredSize = CGSizeMake(totalWidth, maxHeight);
    }
}

- (void)layoutView {
    if (_orientation == MJGLKLinearLayoutOrientationVertical) {
        CGFloat currentX = self.layoutSpec.padding.left;
        CGFloat currentY = self.layoutSpec.padding.top;
        
        for (MJGLKView *view in self.views) {
            [self.view addSubview:view.view];
            currentY += view.layoutSpec.margin.top;
            view.view.frame = CGRectMake(currentX + view.layoutSpec.margin.left, 
                                         currentY, 
                                         view.measuredSize.width, 
                                         view.measuredSize.height);
            [view layoutView];
            currentY += (view.measuredSize.height + view.layoutSpec.margin.bottom);
        }
    } else {
        CGFloat currentX = self.layoutSpec.padding.left;
        CGFloat currentY = self.layoutSpec.padding.top;
        
        for (MJGLKView *view in self.views) {
            [self.view addSubview:view.view];
            currentX += view.layoutSpec.margin.left;
            view.view.frame = CGRectMake(currentX, 
                                         currentY + view.layoutSpec.margin.top, 
                                         view.measuredSize.width, 
                                         view.measuredSize.height);
            [view layoutView];
            currentX += (view.measuredSize.width + view.layoutSpec.margin.right);
        }
    }
}

@end
