//
//  ViewControllerDemoFive.m
//  MaskViewDemo
//
//  Created by iOS_Developer on 16/2/25.
//  Copyright © 2016年 CoderJee. All rights reserved.
//

#import "ViewControllerDemoFive.h"
@interface ViewControllerDemoFive ()
@property (nonatomic, weak)CAGradientLayer *gradientLayer;
@property (nonatomic, strong)NSArray *colors;
@property (nonatomic, strong)UILabel *unlock;
@end

#define Random_color [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

@implementation ViewControllerDemoFive

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // 渐变Layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.frame = CGRectMake(0, 200, self.view.bounds.size.width, 64);
    gradientLayer.colors = @[
                             (__bridge id)[UIColor redColor].CGColor,
                              (__bridge id)[UIColor purpleColor].CGColor,
                              (__bridge id)[UIColor orangeColor].CGColor,
                             ];
    gradientLayer.locations = @[@0.25,@0.5,@0.75];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAnimation.fromValue = @[@0, @0, @0.25];
    basicAnimation.toValue = @[@0.75, @1, @1];
    basicAnimation.duration = 2.5;
    basicAnimation.repeatCount = HUGE;
    basicAnimation.autoreverses = YES;
    [gradientLayer addAnimation:basicAnimation forKey:nil];
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"colors"];
    basicAnimation1.fromValue = @[(id)[UIColor greenColor].CGColor, (id)[UIColor purpleColor].CGColor, (id)[UIColor magentaColor].CGColor];
    basicAnimation1.toValue = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor purpleColor].CGColor, (id)[UIColor blueColor].CGColor];
    basicAnimation1.duration = 2.5;
    basicAnimation1.repeatCount = HUGE;
    basicAnimation1.autoreverses = YES;
    [gradientLayer addAnimation:basicAnimation1 forKey:nil];
   
    UILabel *unlock = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    self.unlock = unlock;
    unlock.alpha = 0.5;
    unlock.text = @"滑动来解锁 >>";
    unlock.textAlignment = NSTextAlignmentCenter;
    unlock.font = [UIFont boldSystemFontOfSize:30];
        gradientLayer.mask = unlock.layer;
}

@end
