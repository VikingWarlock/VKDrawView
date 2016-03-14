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
    UITouch *touch = [touches anyObject];
    DrawPoint1=[touch locationInView:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    DrawPoint2=[touch locationInView:self];
    if (TempLine) {
        [TempLine addLineWithPoint1:DrawPoint1 andPoint2:DrawPoint2];
    }
    DrawPoint1=DrawPoint2;
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    DrawPoint2=[touch locationInView:self];
    if (TempLine) {
        [TempLine addLineWithPoint1:DrawPoint1 andPoint2:DrawPoint2];
    }
    DrawPoint2=CGPointZero;
    DrawPoint1=CGPointZero;
    [operationsList addObject:TempLine];
    [canvasList addObject:TempLine];
    TempLine=nil;
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
            
        }else if ([item isKindOfClass:[VKDrawImage class]]){
        
        }else if ([item isKindOfClass:[VKDrawText class]]){
        
        }
    }
    CGContextRef ctx= UIGraphicsGetCurrentContext();

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
