//
//  IceTabBarController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "IceNavigationController.h"
#import "IceTabBar.h"

@interface IceTabBarController ()<IceTabBarDelegate>

@end

@implementation IceTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    ThirdViewController *third = [[ThirdViewController alloc] init];
    ForthViewController *forth = [[ForthViewController alloc] init];
    
    
    [self addChildVc:first title:@"呵呵" image:nil selectedImage:nil];
    [self addChildVc:second title:@"哈哈" image:nil selectedImage:nil];
    [self addChildVc:third title:@"嘿嘿" image:nil selectedImage:nil];
    [self addChildVc:forth title:@"滚~" image:nil selectedImage:nil];
    
    IceTabBar *tabBar = [[IceTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
    

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blueColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor orangeColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    

}


/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 为子控制器包装导航控制器
    IceNavigationController *navigationVc = [[IceNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
}

-(void)tabBarDidClickPlusButton:(IceTabBar *)tabBar{
    NSLog(@"点击了中间的红块");
    [self presentViewController:[[FirstViewController alloc] init] animated:YES completion:nil];
}

@end
