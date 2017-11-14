//
//  SLUChatToolBar.m
//  frame测试
//
//  Created by sanmi on 16/7/18.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "SLUChatToolBar.h"
#import "UIView+Extension.h"

#define ToolBarHeight       60
#define ToolBarWigth        140

@interface SLUChatToolBar ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, assign) CGRect supRect;

@end

@implementation SLUChatToolBar


- (instancetype)initWithSupView:(UIView *)supView
{
    if (self = [super init]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _supRect = [supView.superview convertRect:supView.frame toView:window];
        NSLog(@"%@", NSStringFromCGRect(_supRect));
        [self addView];
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.alpha = 0;
    }
    return self;
}

- (void)addView{
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ToolBarWigth, ToolBarHeight)];
    _imgView.ice_centerX = _supRect.origin.x + _supRect.size.width / 2.0;
    _imgView.y = _supRect.origin.y - ToolBarHeight;
    _imgView.image = [UIImage imageNamed:@"多边形-1"];
    _imgView.userInteractionEnabled = YES;
    
    [self addSubview:_imgView];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(70 * i, 0, ToolBarWigth/2.0, ToolBarHeight - 15)];
        if ( i== 0) {
            [btn setTitle:@"复制" forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"删除" forState:UIControlStateNormal];
        }
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imgView addSubview:btn];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ToolBarWigth/2.0 - 1.5 , 0, 1, ToolBarHeight - 20)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_imgView addSubview:lineView];
}

- (void)btnClick:(UIButton *)sender{
    NSLog(@"%ld", (long)sender.tag);
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = [UIScreen mainScreen].bounds;
    [window addSubview:self];
    [UIView animateWithDuration:.25f animations:^{
        self.alpha = 1;
    }];
}

- (void)cancel{
    [UIView animateWithDuration:.25f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *view = [window.subviews lastObject];
        [view removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    [self cancel];
}


@end
