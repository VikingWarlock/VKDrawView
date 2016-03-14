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
}

-(instancetype)initWithDrawLayer:(VKDrawLayer *)layer
{
    self=[super initWithDrawLayer:layer];
    if (self) {
        colorList=[NSMutableArray array];
        widthList=[NSMutableArray array];
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

-(void)doneEdit
{
    [super doneEdit];
//    CGRect bound=CGPathGetBoundingBox(self.LinePath);
    UIGraphicsBeginImageContextWithOptions(superContentView.frame.size, NO, 0);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, CGRectMake(0, 0, superContentView.frame.size.width, superContentView.frame.size.height));
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
    CGContextAddPath(ctx, self.LinePath);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, self.LineWidth);
    CGContextSetStrokeColorWithColor(ctx, self.LineColor.CGColor);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextStrokePath(ctx);
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