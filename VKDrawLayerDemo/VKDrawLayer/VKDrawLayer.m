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
    
    UIColor *cc;
    CGFloat cw;
    
    BOOL needRedrawSavedLayer;
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
    VKDrawImage *i=[[VKDrawImage alloc]initWithDrawLayer:self];
    i.image=[UIImage imageNamed:@"04.png"];
    i.visible=YES;
    
    [canvasList addObject:i];
    operationsList=[NSMutableArray array];
    DrawPoint1=CGPointZero;
    DrawPoint2=CGPointZero;
    self.lineColor=[UIColor greenColor];
    self.lineWidth=10;
    needRedrawSavedLayer=NO;
}

#pragma Public Method

-(void)setLineWidth:(CGFloat)lineWidth
{
    TempLine.LineWidth=lineWidth;
    cw=lineWidth;
}

-(void)setLineColor:(UIColor *)lineColor
{
    TempLine.LineColor=lineColor;
    cc=[lineColor copy];
}


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
    if (TempLine==nil) {
        TempLine=[[VKDrawLine alloc]initWithDrawLayer:self];
        TempLine.LineColor=cc;
        TempLine.LineWidth=cw;
        [canvasList addObject:TempLine];
    }
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
    if (![operationsList containsObject:TempLine]) {
        [operationsList addObject:TempLine];
    }
    
    [TempLine doneEdit];
    
    if ([self.delegate respondsToSelector:@selector(didDrawLine:)]) {
        [self.delegate didDrawLine:TempLine];
    }
    [self setNeedsDisplay];
}

-(void)CreateNewLayer
{
    TempLine=nil;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma Redraw
-(void)drawRect:(CGRect)rect
{
    if (needRedrawSavedLayer||YES) {
        for(VKPicLayer *item in self.LayerList)
        {
            if (item.visible==NO) {
                continue;
            }
            
            if ([item isKindOfClass:[VKDrawLine class]]) {
                [item drawOnTheContext];
                continue;
            }
            
            if ([item isKindOfClass:[VKDrawImage class]]) {
                [item drawOnTheContext];
                continue;
            }
            
            
        }
    }else
    {
        
    }
    
    if(TempLine&&TempLine.visible){
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
