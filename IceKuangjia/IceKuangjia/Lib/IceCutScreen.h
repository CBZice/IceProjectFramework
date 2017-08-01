//
//  IceCutScreen.h
//  IceAnimation
//
//  Created by shoujizhifu on 2017/7/27.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^cutScreen)(UIImage *image);

@interface IceCutScreen : NSObject

//@property (nonatomic, copy) void (^cutScreen)(UIImage *image);

+ (void)cutScreenWithImage:(cutScreen)screenBlock;

@end
