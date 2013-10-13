//
//  ImageViewController.m
//  Draw
//
//  Created by DungNT on 10/11/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    self.view = [[UIView alloc] initWithFrame:appFrame];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 100, 30);
    [button addTarget:self action:@selector(backToDraw:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect imageFrame = CGRectMake(100, 200, 200, 200);
    UserResizableView *imageResizableView = [[UserResizableView alloc] initWithFrame:imageFrame];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageResizableView.contentView = imageView;
    imageResizableView.delegate = self;
    [self.view addSubview:imageResizableView];
    [imageView release]; [imageResizableView release];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditingHandles)];
    [gestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
}

- (void)userResizableViewDidBeginEditing:(UserResizableView *)userResizableView {
    [currentlyEditingView hideEditingHandles];
    currentlyEditingView = userResizableView;
}

- (void)userResizableViewDidEndEditing:(UserResizableView *)userResizableView {
    lastEditedView = userResizableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([currentlyEditingView hitTest:[touch locationInView:currentlyEditingView] withEvent:nil]) {
        return NO;
    }
    return YES;
}

- (void)hideEditingHandles {
    // We only want the gesture recognizer to end the editing session on the last
    // edited view. We wouldn't want to dismiss an editing session in progress.
    [lastEditedView hideEditingHandles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToDraw:(id)sender {
    PaintViewController *paintView = [[PaintViewController alloc] initWithNibName:@"PaintViewController" bundle:nil];
    paintView.drawingView = [[DrawingView alloc] initWithFrame:CGRectMake(0, 44, 1024, 704)];
    paintView.drawingView.image = self.image;
    [paintView.drawingView addimageToView];
    [self presentViewController:paintView animated:YES completion:nil];
    
}
@end
