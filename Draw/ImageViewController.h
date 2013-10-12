//
//  ImageViewController.h
//  Draw
//
//  Created by DungNT on 10/11/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import "SPUserResizableView.h"
#import "PaintViewController.h"
#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIGestureRecognizerDelegate, SPUserResizableViewDelegate>{
    SPUserResizableView *currentlyEditingView;
    SPUserResizableView *lastEditedView;
}

@property (strong, nonatomic) UIImage *image;
- (IBAction)backToDraw:(id)sender;

@end
