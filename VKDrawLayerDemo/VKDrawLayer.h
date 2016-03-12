//
//  VKDrawLayer.h
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKPicLayer;

@protocol VKDrawLayerProcotol <NSObject>

-(void)didDrawLine:(VKPicLayer*)layer;

@end

@interface VKDrawLayer : UIView

-(void)addPic:(UIImage*)image;

-(void)addText:(NSString*)text;


-(void)removeLayer:(VKPicLayer*)layer;

-(void)insertLayer:(VKPicLayer*)layer atIndex:(NSUInteger)index;

-(void)doneEdit;

-(void)mirrorPic;

-(BOOL)canUndo;
-(BOOL)undo;
-(BOOL)canRedo;
-(BOOL)redo;

@property(nonatomic,readonly)NSArray *operations;

@property(nonatomic,readonly)NSArray *LayerList;

@property(nonatomic,weak)UIView *controlView;

@property(nonatomic,assign)UIColor *canvasBackgroundColor;



@end
