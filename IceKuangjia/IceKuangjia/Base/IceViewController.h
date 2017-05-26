//
//  IceViewController.h
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavBtn)(NSInteger index);

@interface IceViewController : UIViewController

//右边图片数组
- (void)rightBtnItemWithimgNames:(NSArray *)imgStrArr block:(NavBtn)right;
//右边一张图片按钮
- (void)rightBtnItemWithimgName:(NSString *)imgStr block:(NavBtn)right;
//右边一个文字描述按钮
- (void)rightBtnItemWithTitle:(NSString *)title block:(NavBtn)right;


//左边图片数组
- (void)leftBtnItemWithimgNames:(NSArray *)imgStrArr block:(NavBtn)left;
//左边一张图片按钮
- (void)leftBtnItemWithimgName:(NSString *)imgStr block:(NavBtn)left;
//左边一个文字描述按钮
- (void)leftBtnItemWithTitle:(NSString *)title block:(NavBtn)left;

@end
