//
//  VKPicLayer.h
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class VKDrawLayer;
@class VKPicLayer;

//void drawVKlayerOntheContext(CGContextRef ctx,VKPicLayer *layer);


@interface VKPicLayer : NSObject
{
    VKDrawLayer *superContentView;
    UIImage *thumb;
    
}
-(instancetype)initWithDrawLayer:(VKDrawLayer*)layer;

-(void)doneEdit;

@property(nonatomic,assign)BOOL showBorder;
@property(nonatomic,assign)UIColor *borderColor;
@property(nonatomic,readonly)UIImage *SmallPic;
@property(nonatomic,assign)BOOL visible;
-(void)drawOnTheContext;

@end


@interface VKDrawLine : VKPicLayer
//@property (nonatomic) CGMutablePathRef TempLinePath;
@property (nonatomic) NSMutableArray *LinePaths;
@property (nonatomic,assign) CGFloat LineWidth;
@property (nonatomic,copy) UIColor *LineColor;
-(void)addLineWithPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;
@end

@interface VKDrawText : VKPicLayer
@property (nonatomic,copy)NSString *character;
@property (nonatomic,assign)UIFont *font;
@property (nonatomic,assign)UIColor *textColor;
@end

@interface VKDrawImage : VKPicLayer
@property (nonatomic,assign)UIImage *image;
@end

