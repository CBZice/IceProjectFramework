//
//  QRCodeRectViewVC.h
//  曲线图
//
//  Created by shoujizhifu on 2017/7/31.
//  Copyright © 2017年 whq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeRectViewVC : UIViewController

// 最终按钮
@property (nonatomic, copy) void (^qrHaveResult)(NSString *result);

@end
