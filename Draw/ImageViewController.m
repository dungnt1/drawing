//
//  ImageViewController.m
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import "ImageViewController.h"
#import "PaintViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (IBAction)backToDraw:(id)sender {
    PaintViewController *paintView = [[PaintViewController alloc]initWithNibName:@"PaintViewController" bundle:nil];
    paintView.drawingView = self.drawingView;
    [self presentViewController:paintView animated:YES completion:nil];
}

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.previewImageView.image = self.image;
    
    
    self.previewImageView.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
