//
//  IceImageView.m
//  放大图片
//
//  Created by sanmi on 16/11/3.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceImageView.h"

@interface IceImageView ()
{
    CGRect _supRect;
    UIImageView *shandowView;
    UIView *backView;
}

@end

@implementation IceImageView

- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _openTapGes = _openLongPressGes = YES;
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longGes];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_openTapGes) return;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _supRect = [self.superview convertRect:self.frame toView:window];
    if (!shandowView) {
        
        backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0;
        [window addSubview:backView];
        
        shandowView = [[UIImageView alloc] initWithFrame:_supRect];
        [window addSubview:shandowView];
        shandowView.userInteractionEnabled = YES;
        shandowView.backgroundColor = [UIColor clearColor];
        shandowView.contentMode = UIViewContentModeScaleAspectFit;
        shandowView.image = self.image;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
        [shandowView addGestureRecognizer:ges];
    }
    [UIView animateWithDuration:0.5 animations:^{
        shandowView.frame = [UIScreen mainScreen].bounds;
        backView.alpha = 0.4;
    }];
}

- (void)cancel:(UITapGestureRecognizer *)tapGes {
    [UIView animateWithDuration:0.5 animations:^{
        shandowView.frame = _supRect;
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [shandowView removeFromSuperview];
            [backView removeFromSuperview];
            shandowView = nil;
            backView = nil;
        }
    }];
}

- (void)longPress:(UILongPressGestureRecognizer *)longGes {
    if (!_openLongPressGes) return;
    if ([self.delegate respondsToSelector:@selector(imageView:LongPressGesState:)]) {
        [self.delegate imageView:self LongPressGesState:longGes.state];
    }
}

@end
