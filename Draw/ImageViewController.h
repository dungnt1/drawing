//
//  ImageViewController.h
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface ImageViewController : UIViewController

@property (nonatomic, unsafe_unretained) IBOutlet UIImageView *previewImageView;
@property (nonatomic, unsafe_unretained) IBOutlet UIImage *image;

@property (nonatomic, strong) DrawingView *drawingView;

@end
