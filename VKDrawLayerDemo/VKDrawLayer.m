//
//  VKDrawLayer.m
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "VKDrawLayer.h"
#import "VKPicLayer.h"

@interface VKDrawLayer()
{
    VKDrawLine *TempLine;
    CGPoint DrawPoint1;
    CGPoint DrawPoint2;
    NSMutableArray *operationsList;
    NSMutableArray *canvasList;
}
@end


@implementation VKDrawLayer


#pragma initMethod

-(instancetype)init
{
    self=[super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    canvasList=[NSMutableArray array];
    operationsList=[NSMutableArray array];
    DrawPoint1=CGPointZero;
    DrawPoint2=CGPointZero;
    _lineColor=[UIColor greenColor];
    _lineWidth=10;
}

#pragma Public Method


-(void)doneEdit
{

}

-(void)mirrorPic
{

}

-(void)addPic:(UIImage *)image
{

}

-(void)addText:(NSString *)text
{

}

-(void)removeLayer:(VKPicLayer *)layer
{

}

-(void)insertLayer:(VKPicLayer *)layer atIndex:(NSUInteger)index
{

}

-(BOOL)undo
{
    return NO;

}

-(BOOL)canUndo
{
    return NO;

}

-(BOOL)redo
{
    return NO;

}

-(BOOL)canRedo
{
    return NO;
}

-(NSArray *)operations
{
    return [NSArray arrayWithArray:operationsList];
}

-(NSArray *)LayerList
{
    return [NSArray arrayWithArray:canvasList];
}


-(void)setCanvasBackgroundColor:(UIColor *)canvasBackgroundColor
{
    self.backgroundColor=canvasBackgroundColor;
}

#pragma Touch

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TempLine=[[VKDrawLine alloc]initWithDrawLayer:self];
    TempLine.LineColor=_lineColor;
    TempLine.LineWidth=_lineWidth;
    UITouch *touch = [touches anyObject];
    DrawPoint1=[touch locationInView:self];
    
//    NSLog(@"start point %f,%f",DrawPoint1.x,DrawPoint1.y);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    DrawPoint2=[touch locationInView:self];
    if (TempLine) {
        [TempLine addLineWithPoint1:DrawPoint1 andPoint2:DrawPoint2];
    }
    DrawPoint1=DrawPoint2;
//    NSLog(@"now point %f,%f",DrawPoint1.x,DrawPoint1.y);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    DrawPoint2=[touch locationInView:self];
//    NSLog(@"current point %f,%f",DrawPoint2.x,DrawPoint2.y);
    if (TempLine) {
        [TempLine addLineWithPoint1:DrawPoint1 andPoint2:DrawPoint2];
    }
    DrawPoint2=CGPointZero;
    DrawPoint1=CGPointZero;
    [operationsList addObject:TempLine];
    [canvasList addObject:TempLine];
    TempLine=nil;
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma Redraw
-(void)drawRect:(CGRect)rect
{
    for(VKPicLayer *item in self.LayerList)
    {
        if ([item isKindOfClass:[VKDrawLine class]]) {
            [item drawOnTheContext];
        }
     
    }
    
    if(TempLine){
        [TempLine drawOnTheContext];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
