//
//  VKPicLayer.m
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "VKPicLayer.h"
#import "VKDrawLayer.h"
//void drawVKlayerOntheContext(CGContextRef ctx,VKPicLayer *layer)
//{
//    if ([layer isKindOfClass:[VKDrawLine class]]) {
//        
//        CGContextRef ctx=UIGraphicsGetCurrentContext();
//        CGContextAddPath(ctx, ((VKDrawLine*)layer).LinePath);
//        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
//        CGContextSetLineCap(ctx, kCGLineCapRound);
//        CGContextSetStrokeColorWithColor(ctx, ((VKDrawLine*)layer).LineColor.CGColor);
//        CGContextSetLineWidth(ctx, ((VKDrawLine*)layer).LineWidth);
//        CGContextStrokePath(ctx);
//
//        
//    }else if([layer isKindOfClass:[VKDrawImage class]])
//    {
//    
//    }else if ([layer isKindOfClass:[VKDrawText class]])
//    {
//    
//    }
//
//}
@interface VKPicLayer()
@end

@implementation VKPicLayer

-(instancetype)initWithDrawLayer:(VKDrawLayer *)layer
{
    self=[super init];
    if (self) {
        superContentView=layer;
        self.visible=YES;
    }
    return self;
}

-(void)drawOnTheContext
{
    
}

-(void)doneEdit
{
    
}

-(UIImage *)SmallPic
{
    return thumb;
}

@end




@implementation VKDrawLine
{
    NSMutableArray *colorList;
    NSMutableArray *widthList;
    UIColor *currentColor;
    CGFloat currentWidth;
    CGMutablePathRef tempPath;
}

-(instancetype)initWithDrawLayer:(VKDrawLayer *)layer
{
    self=[super initWithDrawLayer:layer];
    if (self) {
        colorList=[NSMutableArray array];
        widthList=[NSMutableArray array];
        self.LinePaths=[NSMutableArray array];
        currentColor=[UIColor greenColor];
        currentWidth=8;
    
    }
    return self;
}

-(void)setLineColor:(UIColor *)LineColor
{
    if (!CGColorEqualToColor(LineColor.CGColor, currentColor.CGColor)) {
        if (tempPath) {
            UIBezierPath *path=[UIBezierPath bezierPathWithCGPath:tempPath];
            [_LinePaths addObject:path];
            [colorList addObject:[currentColor copy]];
            [widthList addObject:@(currentWidth)];
            CGPathRelease(tempPath);
            tempPath=nil;
        }
    }
    currentColor=[LineColor copy];
}

-(void)setLineWidth:(CGFloat)LineWidth
{
    if (LineWidth!=currentWidth) {
        if (tempPath) {
            UIBezierPath *path=[UIBezierPath bezierPathWithCGPath:tempPath];
            [_LinePaths addObject:path];
            [colorList addObject:[currentColor copy]];
            [widthList addObject:@(currentWidth)];
            CGPathRelease(tempPath);
            tempPath=nil;
        }
    }
    currentWidth=LineWidth;
}


-(void)dealloc
{
    CGPathRelease(tempPath);
}

-(void)addLineWithPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2
{
    if (tempPath==nil) {
        tempPath=CGPathCreateMutable();
    }
    
    CGMutablePathRef newPath= CGPathCreateMutable();
    CGPathMoveToPoint(newPath, nil, point1.x, point1.y);
    CGPathAddQuadCurveToPoint(newPath, nil, point1.x, point1.y, point2.x, point2.y);
    CGPathAddPath(tempPath, nil, newPath);
    CGPathRelease(newPath);
}


-(void)drawOnTheContext
{
    [super drawOnTheContext];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    int count=0;
    for(UIBezierPath *path in _LinePaths)
    {
        UIColor *color=colorList[count];
        CGFloat width=[widthList[count] floatValue];
        CGContextSetStrokeColorWithColor(ctx, color.CGColor);
        CGContextSetLineWidth(ctx, width);
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);
        count++;
    }
    if (tempPath) {
        CGContextAddPath(ctx, tempPath);
        CGContextSetStrokeColorWithColor(ctx, currentColor.CGColor);
        CGContextSetLineWidth(ctx, currentWidth);
        CGContextStrokePath(ctx);
    }
}

-(void)doneEdit
{
    [super doneEdit];
//    CGRect bound=CGPathGetBoundingBox(self.LinePath);
    UIGraphicsBeginImageContextWithOptions(superContentView.frame.size, NO, 0);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, superContentView.frame.size.width, superContentView.frame.size.height));
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
    [self drawOnTheContext];
    UIImage *thumbImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    thumb=thumbImage;
}

@end

@implementation VKDrawImage

-(void)drawOnTheContext
{

    
}

@end

@implementation VKDrawText

-(void)drawOnTheContext
{

    
}

@end