//
//  DrawingTools.m
//  Draw
//
//  Created by DungNT on 9/25/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import "DrawingTools.h"

CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

#pragma mark - DrawingPenTool

@implementation DrawingPenTool

@synthesize lineColor = _lineColor;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.lineCapStyle = kCGLineCapRound;
        path = CGPathCreateMutable();
    }
    return self;
}

- (void)setInitialPoint:(CGPoint)firstPoint
{
    //[self moveToPoint:firstPoint];
}

- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    //[self addQuadCurveToPoint:midPoint(endPoint, startPoint) controlPoint:startPoint];
}

- (CGRect)addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint {
    
    CGPoint mid1 = midPoint(p1Point, p2Point);
    CGPoint mid2 = midPoint(cpoint, p1Point);
    CGMutablePathRef subpath = CGPathCreateMutable();
    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(subpath, NULL, p1Point.x, p1Point.y, mid2.x, mid2.y);
    CGRect bounds = CGPathGetBoundingBox(subpath);
    
    CGPathAddPath(path, NULL, subpath);
    CGPathRelease(subpath);
    
    return bounds;
}

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextStrokePath(context);
}

- (void)dealloc
{
    CGPathRelease(path);
    self.lineColor = nil;
#if !HAS_ARC
    [super dealloc];
#endif
}

@end

#pragma mark - DrawingEraserTool

@implementation DrawingEraserTool

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextStrokePath(context);
}

@end

#pragma mark - DrawingPencilTool

@implementation DrawingPencilTool

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetAlpha(context, 0.5);
	CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextStrokePath(context);
}

@end

#pragma mark - DrawingDustTool

@implementation DrawingDustTool

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth*3);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextStrokePath(context);
    CGFloat dashes[] = { 1, 1 };

    CGContextSetLineDash( context, 0.0, dashes, 2 );
}

@end

#pragma mark - DrawingLineTool

@interface DrawingLineTool ()
@property (nonatomic, assign) CGPoint firstPoint;
@property (nonatomic, assign) CGPoint lastPoint;
@end

#pragma mark -

@implementation DrawingLineTool

@synthesize lineColor = _lineColor;
@synthesize lineWidth = _lineWidth;

- (void)setInitialPoint:(CGPoint)firstPoint
{
    self.firstPoint = firstPoint;
}

- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    self.lastPoint = endPoint;
}

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the line properties
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    // draw the line
    CGContextMoveToPoint(context, self.firstPoint.x, self.firstPoint.y);
    CGContextAddLineToPoint(context, self.lastPoint.x, self.lastPoint.y);
    CGContextStrokePath(context);
}

- (void)dealloc
{
    self.lineColor = nil;
#if !HAS_ARC
    [super dealloc];
#endif
}

@end
//
//#pragma mark - DrawingRectangleTool
//
//@interface DrawingRectangleTool ()
//@property (nonatomic, assign) CGPoint firstPoint;
//@property (nonatomic, assign) CGPoint lastPoint;
//@end
//
//#pragma mark -
//
//@implementation DrawingRectangleTool
//
//@synthesize lineColor = _lineColor;
//@synthesize lineWidth = _lineWidth;
//
//- (void)setInitialPoint:(CGPoint)firstPoint
//{
//    self.firstPoint = firstPoint;
//}
//
//- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
//{
//    self.lastPoint = endPoint;
//}
//
//- (void)draw
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // draw the rectangle
//    CGRect rectToFill = CGRectMake(self.firstPoint.x, self.firstPoint.y, self.lastPoint.x - self.firstPoint.x, self.lastPoint.y - self.firstPoint.y);
//    if (self.fill) {
//        CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
//        CGContextFillRect(UIGraphicsGetCurrentContext(), rectToFill);
//        
//    } else {
//        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
//        CGContextSetLineWidth(context, self.lineWidth);
//        CGContextStrokeRect(UIGraphicsGetCurrentContext(), rectToFill);
//    }
//}
//
//- (void)dealloc
//{
//    self.lineColor = nil;
//#if !HAS_ARC
//    [super dealloc];
//#endif
//}
//
//@end
//
#pragma mark - DrawingEllipseTool

@interface DrawingEllipseTool ()
@property (nonatomic, assign) CGPoint firstPoint;
@property (nonatomic, assign) CGPoint lastPoint;
@end

#pragma mark -

@implementation DrawingEllipseTool

@synthesize lineColor = _lineColor;
@synthesize lineWidth = _lineWidth;

- (void)setInitialPoint:(CGPoint)firstPoint
{
    self.firstPoint = firstPoint;
}

- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    self.lastPoint = endPoint;
}

- (void)draw
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    // draw the ellipse
    CGRect rectToFill = CGRectMake(self.firstPoint.x, self.firstPoint.y, self.lastPoint.x - self.firstPoint.x, self.lastPoint.y - self.firstPoint.y);
    if (self.fill) {
        CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
        CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), rectToFill);
        
    } else {
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextStrokeEllipseInRect(UIGraphicsGetCurrentContext(), rectToFill);
    }
}

- (void)dealloc
{
    self.lineColor = nil;
#if !HAS_ARC
    [super dealloc];
#endif
}

@end
