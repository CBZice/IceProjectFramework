//
//  UIView+EBAddMessage.h
//  ExpressBusiness
//
//  Created by shoujizhifu on 2017/8/29.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EBAddMessage)

- (void)addMessageViewWithTitle:(NSString *)title DetailTiltle:(NSString *)detailTitle imgName:(NSString *)imgName;

- (void)addMessageViewWithTitle:(NSString *)title btnTiltle:(NSString *)btnTiltle imgName:(NSString *)imgName btnBlock:(void(^)())block;

@property (nonatomic, strong) UIView *messageContentView;

@property (nonatomic, copy) void (^btnClick)();

@end
