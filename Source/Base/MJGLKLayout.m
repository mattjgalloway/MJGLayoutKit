//
//  MJGLKLayout.m
//  MJGLayoutKit
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file requires ARC to be enabled. Either enable ARC for the entire project or use -fobjc-arc flag.
#endif

#import "MJGLKLayout.h"

#import "MJGLKView+Private.h"

@interface MJGLKLayout ()
@property (nonatomic, strong) NSMutableArray *mutableViews;
@end

@implementation MJGLKLayout

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
    [self.layout setNeedsLayout];
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
