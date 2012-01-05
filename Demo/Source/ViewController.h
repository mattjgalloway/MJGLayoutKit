//
//  ViewController.h
//  MJGLayoutKitDemo
//
//  Created by Matt Galloway on 03/01/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJGLayoutKit/MJGLayoutKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *layoutContainer;

@property (nonatomic, strong) MJGLKRootView *layout;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MJGLKUIViewWrapper *image;

- (id)init;

- (IBAction)toggleImage:(id)sender;

@end
