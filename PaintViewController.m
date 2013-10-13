//
//  PaintViewController.m
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import "PaintViewController.h"
#import "DrawingView.h"
#import "ColorCell.h"
#import "ImageViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kActionSheetColor       100
#define kActionSheetTool        101

@interface PaintViewController ()<UIActionSheetDelegate, DrawingViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *colorData;
}

@end

@implementation PaintViewController
-(void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set the color data
//    colorData = [[NSArray alloc]initWithObjects:[UIColor blackColor],
//                                                [UIColor blueColor],
//                                                [UIColor whiteColor],
//                                                [UIColor grayColor],
//                                                [UIColor greenColor],
//                                                nil];
    
    // set drawing view
    DrawingView *drawView = [[DrawingView alloc]initWithFrame:CGRectMake(0, 44, 1024, 704)];
    if (self.drawingView.image != nil) {
        [drawView setBackgroundColor:[UIColor colorWithPatternImage:self.drawingView.image]];
    }
    self.drawingView = drawView;
    
    [self.view addSubview:drawView];
    
    self.drawingView.delegate = self;        
    // init the drawingView with border
    self.drawingView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.drawingView.layer.borderWidth = 3.0f;
    
    
    UINib *cellNib = [UINib nibWithNibName:@"ColorCell" bundle:nil];
    [self.colorCollection registerNib:cellNib forCellWithReuseIdentifier:@"ColorCell"];
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)updateButtonStatus
{
    self.undoButton.enabled = [self.drawingView canUndo];
    self.redoButton.enabled = [self.drawingView canRedo];
}

- (IBAction)saveImage:(id)sender
{
    // Send drawed image to image view
    ImageViewController *imageView = [[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil];
    imageView.image = self.drawingView.image;
    
    [self presentViewController:imageView animated:YES completion:nil];
}

- (IBAction)changeTools:(id)sender {
    switch (self.toolsSegmentedControl.selectedSegmentIndex) {
        case 0:
        {
            self.drawingView.drawTool = DrawingToolTypePen;
            self.colorButton.enabled = TRUE;
        }
            break;
        case 1:
        {
            self.drawingView.drawTool = DrawingToolTypePencil;
            self.colorButton.enabled = TRUE;
        }
            break;
        case 2:
        {
            self.drawingView.drawTool = DrawingToolTypeLine;
            self.colorButton.enabled = TRUE;
        }
            break;
        case 3:
        {
            self.drawingView.drawTool = DrawingToolTypeEllipse;
            self.colorButton.enabled = TRUE;
        }
            break;
        case 4:
        {
            self.drawingView.drawTool = DrawingToolTypeEraser;
            self.colorButton.enabled = TRUE;
        }
            break;
    }
}

- (IBAction)changeWidth:(id)sender {
    self.drawingView.lineWidth = self.widthChange.value;
    [self.widthLabel setText:[NSString stringWithFormat:@"%d",(int)self.widthChange.value]];
}

- (IBAction)undo:(id)sender
{
    [self.drawingView undoLatestStep];
    [self updateButtonStatus];
}

- (IBAction)redo:(id)sender
{
    [self.drawingView redoLatestStep];
    [self updateButtonStatus];
}

- (IBAction)clear:(id)sender
{
    [self.drawingView clear];
    [self updateButtonStatus];
}

#pragma mark - Drawing View Delegate

- (void)drawingView:(DrawingView *)view didEndDrawUsingTool:(id<DrawingTool>)tool;
{
    [self updateButtonStatus];
}

#pragma mark - Settings

- (IBAction)colorChange:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selet a color"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Black", @"Red", @"Green", @"Blue", nil];
    
    [actionSheet setTag:kActionSheetColor];
    [actionSheet showInView:self.view];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [colorData count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *data = [colorData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"ColorCell";
    UICollectionViewCell *color = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [color setBackgroundColor:data];
    return color;
}


#pragma mark - UICollectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *data = [colorData objectAtIndex:indexPath.row];
    self.drawingView.lineColor = data;
    
}
@end
