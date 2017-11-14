//
//  ShowPhotoVC.m
//  IceKuangjia
//
//  Created by 陈冰泽 on 2017/11/7.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import "ShowPhotoVC.h"
#import "UIImageView+CornerRadius.h"
@interface ShowPhotoVC ()

@end

@implementation ShowPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
#pragma mark - 圆形
    UIImageView *imageView = [[UIImageView alloc] initWithRoundingRectImageView];
    [imageView setFrame:CGRectMake(130, 80, 150, 150)];
    [self.view addSubview:imageView];
    
    
    UIImageView *imageViewSecond = [[UIImageView alloc] initWithCornerRadiusAdcance:20.f rectCornerType:UIRectCornerBottomLeft | UIRectCornerTopRight];
    [imageViewSecond setFrame:CGRectMake(130, 280, 150, 150)];
    [self.view addSubview:imageViewSecond];
    
    
    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(130, 480, 150, 150)];
    [imageViewThird ice_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
    [imageViewThird ice_attachBorderWidth:5.f color:[UIColor blackColor]];
    [self.view addSubview:imageViewThird];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 100, 100)];
    [imgView ice_cornerRadiusRoundingRect];
    [imgView ice_attachBorderWidth:5.f color:[UIColor blackColor]];
    [self.view addSubview:imgView];
    
    
#pragma mark - setImage anytime
    imgView.image = imageView.image = [UIImage imageNamed:@"mac_dog"];
    imageViewSecond.image = [UIImage imageNamed:@"mac_dog"];
    imageViewThird.image = [UIImage imageNamed:@"mac_dog"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
