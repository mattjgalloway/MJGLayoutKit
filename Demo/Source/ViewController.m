//
//  ViewController.m
//  MJGLayoutKitDemo
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize layoutContainer;
@synthesize imageView, image, layout;

#pragma mark -

- (IBAction)toggleImage:(id)sender {
    if (imageView.image == [UIImage imageNamed:@"BeerMap_Logo.png"]) {
        self.imageView.image = [UIImage imageNamed:@"BeerMap_Logo_Small.png"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"BeerMap_Logo.png"];
    }
    self.image.contentSize = self.imageView.image.size;
    [self.image setNeedsLayout];
}


#pragma mark -

- (id)init {
    if ((self = [super initWithNibName:@"ViewController" bundle:nil])) {
    }
    return self;
}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BeerMap_Logo.png"]];
    self.image = [[MJGLKUIViewWrapper alloc] initWithUIView:self.imageView];
    self.image.layoutSpec = MJGLKLayoutSpecMake(MJGLKSizeWrapContent, MJGLKSizeWrapContent, 0.0f, UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f), UIEdgeInsetsZero);
    
    UIView *filler1View = [[UIView alloc] initWithFrame:CGRectZero];
    filler1View.backgroundColor = [UIColor blueColor];
    MJGLKUIViewWrapper *filler1 = [[MJGLKUIViewWrapper alloc] initWithUIView:filler1View];
    filler1.layoutSpec = MJGLKLayoutSpecMake(MJGLKSizeFillParent, MJGLKSizeFillParent, 1.0f, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f), UIEdgeInsetsZero);
    
    UIView *filler2View = [[UIView alloc] initWithFrame:CGRectZero];
    filler2View.backgroundColor = [UIColor redColor];
    MJGLKUIViewWrapper *filler2 = [[MJGLKUIViewWrapper alloc] initWithUIView:filler2View];
    filler2.layoutSpec = MJGLKLayoutSpecMake(40, MJGLKSizeFillParent, 0.0f, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f), UIEdgeInsetsZero);
    
    MJGLKLinearLayout *hLinearLayout = [[MJGLKLinearLayout alloc] initWithOrientation:MJGLKLinearLayoutOrientationHorizontal views:[NSArray arrayWithObjects:filler1, filler2, nil]];
    hLinearLayout.view.backgroundColor = [UIColor greenColor];
    hLinearLayout.layoutSpec = MJGLKLayoutSpecMake(MJGLKSizeFillParent, MJGLKSizeFillParent, 1.0f, UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f), UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f));
    
    MJGLKLinearLayout *vLinearLayout = [[MJGLKLinearLayout alloc] initWithOrientation:MJGLKLinearLayoutOrientationVertical views:[NSArray arrayWithObjects:self.image, hLinearLayout, nil]];
    vLinearLayout.layoutSpec = MJGLKLayoutSpecMake(MJGLKSizeFillParent, MJGLKSizeFillParent, 0.0f, UIEdgeInsetsZero, UIEdgeInsetsZero);
    
    self.layout = [[MJGLKRootView alloc] initWithLayout:vLinearLayout];
    
    self.layout.frame = self.layoutContainer.bounds;
    [self.layoutContainer addSubview:self.layout];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.layoutContainer = nil;
    self.imageView = nil;
    self.image = nil;
    self.layout = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
