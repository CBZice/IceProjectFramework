//
//  IceCutScreen.m
//  IceAnimation
//
//  Created by shoujizhifu on 2017/7/27.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "IceCutScreen.h"

static IceCutScreen *iceCutScreen;

@interface IceCutScreen()

@property (nonatomic, copy) cutScreen cutScrren;

@end

@implementation IceCutScreen

+ (void)cutScreenWithImage:(cutScreen)screenBlock {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iceCutScreen = [[IceCutScreen alloc] initWith:screenBlock];
    });
//    iceCutScreen.cutScrren = screenBlock;
}

- (instancetype)initWith:(cutScreen)screenBlock {
    if (self = [super init]) {
        _cutScrren = screenBlock;
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDidTakeScreenshot:)
                                                     name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    }
    return self;
}
//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    
//    //添加显示
//    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
//    imgvPhoto.frame = CGRectMake(keyWindow.frame.size.width/2, keyWindow.frame.size.height/2, keyWindow.frame.size.width/2, keyWindow.frame.size.height/2);
//    
//    //添加边框
//    CALayer * layer = [imgvPhoto layer];
//    layer.borderColor = [
//                         [UIColor whiteColor] CGColor];
//    layer.borderWidth = 5.0f;
//    //添加四个边阴影
//    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
//    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
//    imgvPhoto.layer.shadowOpacity = 0.5;
//    imgvPhoto.layer.shadowRadius = 10.0;
//    //添加两个边阴影
//    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
//    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
//    imgvPhoto.layer.shadowOpacity = 0.5;
//    imgvPhoto.layer.shadowRadius = 2.0;
//    
//    [keyWindow addSubview:imgvPhoto];
    if (_cutScrren) {
        _cutScrren(image_);
    }
}
/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

@end
