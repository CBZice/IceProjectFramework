//
//  TPLoanViewController.h
//  TobaccoPartner
//
//  Created by shoujizhifu on 2017/2/13.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TPLoanViewControllerTypeNormal,
    TPLoanViewControllerTypeShop,   // 商铺管理
    TPLoanViewControllerTypeApply,  // 报件申请
} TPLoanViewControllerType;

@interface TPLoanViewController : UIViewController

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, copy)NSString * codeString;
@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, assign) BOOL push;


@property (nonatomic, strong) NSString *pageName;

@property (nonatomic, assign) TPLoanViewControllerType type;

@end
