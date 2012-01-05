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
@end

@implementation MJGLKView

@synthesize layoutSpec = _layoutSpec;
@synthesize measuredSize = _measuredSize;
@synthesize layout = _layout;

#pragma mark -

- (id)init {
    if ((self = [super init])) {
        _layoutSpec = MJGLKLayoutSpecZero;
        _measuredSize = CGSizeZero;
    }
    return self;
}


#pragma mark -

- (void)removeFromLayout {
    [self.layout removeView:self];
}

- (void)setNeedsLayout {
    [self.layout setNeedsLayout];
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
