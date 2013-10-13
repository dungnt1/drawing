//
//  DrawingView.h
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DrawingToolTypePen,
    DrawingToolTypePencil,
    DrawingToolTypeDust,
    DrawingToolTypeEraser,
    DrawingToolTypeLine,
    DrawingToolTypeEllipse
} DrawingToolType;

@protocol DrawingViewDelegate, DrawingTool;

@interface DrawingView : UIView

@property (nonatomic, assign) DrawingToolType drawTool;
@property (nonatomic, assign) id<DrawingViewDelegate> delegate;

// public properties
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

// get the current drawing
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) NSUInteger undoSteps;

// erase all
- (void)clear;

// undo / redo
- (BOOL)canUndo;
- (void)undoLatestStep;

- (BOOL)canRedo;
- (void)redoLatestStep;

-(void) addimageToView;

- (UIImage*) capture;

@end

#pragma mark -

@protocol DrawingViewDelegate <NSObject>

@optional
- (void)drawingView:(DrawingView *)view willBeginDrawUsingTool:(id<DrawingTool>)tool;
- (void)drawingView:(DrawingView *)view didEndDrawUsingTool:(id<DrawingTool>)tool;

@end
