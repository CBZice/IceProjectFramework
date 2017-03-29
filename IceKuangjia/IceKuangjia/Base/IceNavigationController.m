//
//  IceNavigationController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceNavigationController.h"

@interface IceNavigationController ()

@end

@implementation IceNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置nav中间字体的格式
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor orangeColor]}];

// 用于去除nav导航栏黑线
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"beijing"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:]]];
    
// 用于去除tab导航栏黑线
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setShadowImage:];
    
//设置返回按钮的文字颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

#pragma mark - 改变状态栏颜色与字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - 改变状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self addLeftBtnItemInController:viewController];
    }
    [super pushViewController:viewController animated:animated];
}
/**
 控制器填写self即可,将左边的返回按钮设置为自己想要的
 [self.navigationController addLeftBtnItemInController:self];
 */
- (void)addLeftBtnItemInController:(UIViewController *)viewController{
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_item_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popToOther)];
}

- (void)popToOther{
    [self popViewControllerAnimated:YES];
}

@end
