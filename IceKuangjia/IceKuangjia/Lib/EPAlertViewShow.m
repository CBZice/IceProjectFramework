//
//  EPAlertViewShow.m
//  ExpressPay
//
//  Created by 陈冰泽 on 2017/10/23.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "EPAlertViewShow.h"

@interface EPAlertViewShow()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *alertView;

@end

@implementation EPAlertViewShow

static EPAlertViewShow *alertShowView;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (alertShowView == nil) {
            alertShowView = [super allocWithZone:zone];
        }
    }
    return alertShowView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
        NSLog(@"测试");
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0;
    [self addSubview:_backView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH - 290)/2.0, 2/7.0 * HEIGHT, 290, 165)];
    _alertView.alpha = 0;
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 6;
    _alertView.layer.masksToBounds = YES;
    [self addSubview:_alertView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41, 290, 50)];
    label.text = @"收益=商户交易额*（开通费率-0.27%）\n数据每日更新，截止昨日。";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kUIColorFromRGB(0x666666);
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    [_alertView addSubview:label];
    
    UIButton *knowBtn = [[UIButton alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(label.frame) + 14, 114, 37)];
    knowBtn.backgroundColor = [UIColor colorWithRed:98/255.0 green:150/255.0 blue:250/255.0 alpha:1];
    [knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [knowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    knowBtn.layer.cornerRadius = 5;
    knowBtn.layer.masksToBounds = YES;
    knowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [knowBtn addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:knowBtn];
}

- (void)knowBtnClick {
    [self dismiss];
}

- (void)show {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.alpha = 0.3;
        _alertView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15 animations:^{
        _backView.alpha = 0;
        _alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [alertShowView removeFromSuperview];
        alertShowView = nil;
    }];
}

+ (void)show {
    alertShowView = [[EPAlertViewShow alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertShowView];
    [alertShowView show];
}

+ (void)dismiss {
    [alertShowView dismiss];
}


@end
