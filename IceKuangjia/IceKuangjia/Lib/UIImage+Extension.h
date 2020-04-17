//
//  UIImage+Extension.h
//  ClassDemo
//
//  Created by 陈冰泽 on 2020/4/17.
//  Copyright © 2020 machong. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

+ (UIImage *)ice_bezierPathClip:(UIImage *)img
                  cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)ice_bezierPathClipRound:(UIImage *)img;

@end

NS_ASSUME_NONNULL_END
