//
//  MJGLKLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "MJGLKLayout.h"

#import "MJGLKRootView.h"
#import "MJGLKView+Private.h"

@interface MJGLKLayout ()
@property (nonatomic, unsafe_unretained, readwrite) MJGLKRootView *rootView;
@property (nonatomic, strong) NSMutableArray *mutableViews;
@end

@implementation MJGLKLayout

@synthesize rootView = _rootView;
@synthesize mutableViews = _mutableViews;

#pragma mark -

- (id)initWithViews:(NSArray*)views {
    if ((self = [super init])) {
        self.mutableViews = [[NSMutableArray alloc] initWithCapacity:0];
        for (id view in views) {
            if ([view isKindOfClass:[MJGLKView class]]) {
                [self.mutableViews addObject:view];
                [(MJGLKView*)view setLayout:self];
            }
        }
    }
    return self;
}


#pragma mark - Custom accessors

- (NSArray*)views {
    return [NSArray arrayWithArray:self.mutableViews];
}


#pragma mark -

- (void)setNeedsLayout {
    [super setNeedsLayout];
    if (self.layout) {
        [self.layout setNeedsLayout];
    }
    if (self.rootView) {
        [self.rootView setNeedsLayout];
    }
}


#pragma mark -

- (void)addView:(MJGLKView*)view {
    [self.mutableViews addObject:view];
    view.layout = self;
}

- (void)removeView:(MJGLKView*)view {
    if ([self.mutableViews containsObject:view]) {
        view.layout = nil;
        [self.mutableViews removeObject:view];
    }
}

@end
