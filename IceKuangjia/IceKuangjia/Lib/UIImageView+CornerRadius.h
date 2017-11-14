//
//  UIImageView+CornerRadius.h
//  IceKuangjia
//
//  Created by 陈冰泽 on 2017/11/7.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)

- (instancetype)initWithCornerRadiusAdcance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)ice_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)ice_cornerRadiusRoundingRect;

- (void)ice_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
