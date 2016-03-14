//
//  VKPicLayer.m
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "VKPicLayer.h"

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


@implementation VKPicLayer




-(instancetype)initWithDrawLayer:(VKDrawLayer *)layer
{
    self=[super init];
    if (self) {
        superView=layer;
    }
    return self;
}

-(void)drawOnTheContext
{
    
}


@end


@implementation VKDrawLine

-(instancetype)initWithDrawLayer:(VKDrawLayer *)layer
{
    self=[super initWithDrawLayer:layer];
    if (self) {
        self.LinePath=CGPathCreateMutable();
        self.LineColor=[UIColor greenColor];
        self.LineWidth=8;
    }
    return self;
}

-(void)dealloc
{
    CGPathRelease(self.LinePath);
}

-(void)addLineWithPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2
{
    CGMutablePathRef newPath= CGPathCreateMutable();
    CGPathMoveToPoint(newPath, nil, point1.x, point1.y);
    CGPathAddQuadCurveToPoint(newPath, nil, point1.x, point1.y, point2.x, point2.y);
    CGPathAddPath(self.LinePath, nil, newPath);
    CGPathRelease(newPath);
}

-(void)drawOnTheContext
{
    [super drawOnTheContext];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, self.LinePath);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.LineColor.CGColor);
    CGContextSetLineWidth(ctx, self.LineWidth);
    CGContextStrokePath(ctx);
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