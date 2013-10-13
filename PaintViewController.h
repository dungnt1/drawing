//
//  PaintViewController.h
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface PaintViewController : UIViewController

@property (nonatomic, unsafe_unretained) IBOutlet DrawingView *drawingView;
@property (nonatomic, unsafe_unretained) IBOutlet UIImageView *previewImageView;

@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *undoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *redoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *colorButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *toolButton;
@property (weak, nonatomic) IBOutlet UICollectionView *colorCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toolsSegmentedControl;
@property (weak, nonatomic) IBOutlet UIStepper *widthChange;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
// actions
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)saveImage:(id)sender;
- (IBAction)changeTools:(id)sender;
- (IBAction)changeWidth:(id)sender;

@end
