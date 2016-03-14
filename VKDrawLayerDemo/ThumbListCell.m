//
//  ThumbListCell.m
//  VKDrawLayerDemo
//
//  Created by VKWK on 3/14/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "ThumbListCell.h"

@interface ThumbListCell()
{
    UIImageView *imgView;
}
@end

@implementation ThumbListCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        if (!imgView) {
            imgView=[[UIImageView alloc]init];
            [self addSubview:imgView];
        }
    }
    imgView.frame=CGRectMake(5, 5, frame.size.width-10.f, frame.size.height-10.f);
    return self;
}


-(void)setFrame:(CGRect)frame
{
    if (!imgView) {
        imgView=[[UIImageView alloc]init];
        [self addSubview:imgView];
    }
    imgView.frame=CGRectMake(5, 5, frame.size.width-10.f, frame.size.height-10.f);
}


-(UIImageView *)imageView
{
    return imgView;
}

@end
