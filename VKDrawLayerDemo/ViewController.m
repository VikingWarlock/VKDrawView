//
//  ViewController.m
//  VKDrawLayerDemo
//
//  Created by VikingWarlock on 3/12/16.
//  Copyright © 2016 VikingWarlock. All rights reserved.
//

#import "ViewController.h"
#import "VKDrawLayer.h"

@interface ViewController ()

@property(nonatomic,weak)IBOutlet VKDrawLayer *canvas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(UIColor *)colorList:(int)index
{
    switch (index) {
        case 0:
            return [UIColor redColor];
            break;
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
