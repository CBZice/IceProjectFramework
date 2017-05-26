//
//  IceTabBar.h
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IceTabBar;

#pragma mark - IceTabBar继承自UITabBar，所以IceTabBar的代理必须遵循UITabBar的代理协议！
@protocol IceTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(IceTabBar *)tabBar;

@end

@interface IceTabBar : UITabBar


@property (nonatomic, weak) id<IceTabBarDelegate> delegate;

@end
