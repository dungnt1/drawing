//
//  DrawingTools.h
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define HAS_ARC 1
#define RETAIN(exp) (exp)
#define RELEASE(exp)
#define AUTORELEASE(exp) (exp)
#else
#define HAS_ARC 0
#define RETAIN(exp) [(exp) retain]
#define RELEASE(exp) [(exp) release]
#define AUTORELEASE(exp) [(exp) autorelease]
#endif

@protocol DrawingTool <NSObject>

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)setInitialPoint:(CGPoint)firstPoint;
- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;
- (void)draw;

@end

#pragma mark -

@interface DrawingPenTool : UIBezierPath<DrawingTool> {
    CGMutablePathRef path;
}

- (CGRect)addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint;

@end

#pragma mark -

@interface DrawingEraserTool : DrawingPenTool

@end

#pragma mark -

@interface DrawingPencilTool : DrawingPenTool

@end

#pragma mark -

@interface DrawingDustTool : DrawingPenTool

@end

#pragma mark -

@interface DrawingLineTool : NSObject<DrawingTool>

@end
//
//#pragma mark -
//
//@interface DrawingRectangleTool : NSObject<DrawingTool>
//
//@property (nonatomic, assign) BOOL fill;
//
//@end
//
//#pragma mark -
//
@interface DrawingEllipseTool : NSObject<DrawingTool>

@property (nonatomic, assign) BOOL fill;

@end
