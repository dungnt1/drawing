//
//  PaintViewController.h
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"
//#import "ImageViewController.h"

@interface PaintViewController : UIViewController

@property (nonatomic, unsafe_unretained) IBOutlet DrawingView *drawingView;
@property (nonatomic, unsafe_unretained) IBOutlet UISlider *lineWidthSlider;
@property (nonatomic, unsafe_unretained) IBOutlet UIImageView *previewImageView;

@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *undoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *redoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *colorButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *toolButton;
@property (weak, nonatomic) IBOutlet UICollectionView *colorCollection;

// actions
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)saveImage:(id)sender;

// settings
- (IBAction)colorChange:(id)sender;
- (IBAction)penTool:(id)sender;
- (IBAction)lineTool:(id)sender;
- (IBAction)rectStrokeTool:(id)sender;
- (IBAction)rectFillTool:(id)sender;
- (IBAction)elipStrokeTool:(id)sender;
- (IBAction)elipFillTool:(id)sender;
- (IBAction)eraserTool:(id)sender;
- (IBAction)toggleWidthSlider:(id)sender;
- (IBAction)widthChange:(UISlider *)sender;

@end
