//
//  IceTabBar.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceTabBar.h"

@interface IceTabBar()

@property (nonatomic, weak) UIButton *plusBtn;

@end


@implementation IceTabBar

@dynamic delegate;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundColor:Random_color];
        plusBtn.size = CGSizeMake(WIDTH / 5.0 , 70);
        
        NSLog(@"%f",[UIScreen mainScreen].bounds.size.width / 5.0);
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%@",self.subviews);
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}


/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;
    NSLog(@"%@",NSStringFromCGRect(self.plusBtn.frame));
    
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.width / 5.0;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    
    }
}

@end
