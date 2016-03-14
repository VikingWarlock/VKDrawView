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

@interface VKPicLayer : NSObject

-(instancetype)initWithDrawLayer:(VKDrawLayer*)layer;

@property(nonatomic,assign)BOOL showBorder;
@property(nonatomic,assign)UIColor *borderColor;

-(void)drawOnTheContext;

@end


@interface VKDrawLine : VKPicLayer
@property (nonatomic) CGMutablePathRef LinePath;
@property (nonatomic,assign) CGFloat LineWidth;
@property (nonatomic,assign) UIColor *LineColor;
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

