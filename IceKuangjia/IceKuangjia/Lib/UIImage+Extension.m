//
//  UIImage+Extension.m
//  ClassDemo
//
//  Created by 陈冰泽 on 2020/4/17.
//  Copyright © 2020 machong. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)ice_bezierPathClip:(UIImage *)img
                  cornerRadius:(CGFloat)cornerRadius {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    CGRect rect = (CGRect){CGPointZero, CGSizeMake(w, h)};

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [img drawInRect:rect];
    UIImage *cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cornerImage;
}

+(UIImage *)ice_bezierPathClipRound:(UIImage *)img {
    CGFloat imgWidth = img.size.width < img.size.height ? img.size.width : img.size.height;
    CGRect rect = CGRectMake(0, 0, imgWidth, imgWidth);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imgWidth, imgWidth), NO, 0.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:imgWidth] addClip];
    [img drawInRect:rect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    return img;
}
@end
