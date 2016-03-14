//
//  ViewController.m
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "ViewController.h"
#import "VKDrawLayer.h"
#import "VKPicLayer.h"
#import "ThumbListCell.h"

static NSString *cellId=@"cell";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,VKDrawLayerProcotol>
{
    UICollectionViewFlowLayout *collectionLayout;

}

@property(nonatomic,weak)IBOutlet VKDrawLayer *canvas;
@property(nonatomic,weak)IBOutlet UICollectionView *thumbList;
@end

@implementation ViewController


-(void)didDrawLine:(VKPicLayer *)layer
{
    [self.thumbList reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.thumbList registerClass:[ThumbListCell class] forCellWithReuseIdentifier:cellId];
    collectionLayout=[[UICollectionViewFlowLayout alloc]init];
    collectionLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    collectionLayout.itemSize=CGSizeMake(60, 60);
    self.canvas.delegate=self;
    self.thumbList.backgroundColor=[UIColor whiteColor];
    self.thumbList.collectionViewLayout=collectionLayout;
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)newL
{
    [self.canvas CreateNewLayer];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.canvas.LayerList.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThumbListCell *cell=(ThumbListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    VKPicLayer *item=self.canvas.LayerList[indexPath.item];
    cell.imageView.image=item.SmallPic;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    VKPicLayer *item=self.canvas.LayerList[indexPath.item];
    BOOL visible=item.visible;
    item.visible=!visible;
    [self.canvas setNeedsDisplay];
}

-(UIColor *)colorList:(int)index
{
    switch (index) {
        case 0:
            return [UIColor redColor];
        case 1:
            return [UIColor yellowColor];
        case 2:
            return [UIColor greenColor];
        case 3:
            return [UIColor blueColor];
        case 4:
            return [UIColor whiteColor];
        default:
            return [UIColor cyanColor];
            break;
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        int color=arc4random() %4;
        int width=arc4random() %8+6;
        self.canvas.lineColor=[self colorList:color];
        self.canvas.lineWidth=width;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
