//
//  UIView+EBAddMessage.m
//  ExpressBusiness
//
//  Created by shoujizhifu on 2017/8/29.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "UIView+EBAddMessage.h"
#import <Masonry/Masonry.h>

@implementation UIView (EBAddMessage)

- (void)addMessageViewWithTitle:(NSString *)title DetailTiltle:(NSString *)detailTitle imgName:(NSString *)imgName{
    
    if (self.messageContentView) {
        self.messageContentView.hidden = NO;
        return;
    }
    
    self.messageContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, self.mj_h - 64)];
    self.messageContentView.backgroundColor = BackGroundColor;
    [self addSubview:self.messageContentView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = title;
    tipLabel.textColor = kUIColorFromRGB(0x666666);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:15.f];
    [self.messageContentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    if (imgName.length > 0) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:imgName];
        [self.messageContentView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(tipLabel.mas_top).offset(-10);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    
    if (detailTitle.length > 0) {
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel = [[UILabel alloc] init];
        detailLabel.text = detailTitle;
        detailLabel.textColor = kUIColorFromRGB(0x999999);
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [UIFont systemFontOfSize:14.f];
        [self.messageContentView addSubview:detailLabel];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
}

- (void)addMessageViewWithTitle:(NSString *)title btnTiltle:(NSString *)btnTiltle imgName:(NSString *)imgName btnBlock:(void(^)())block{
    self.btnClick = block;
    if (self.messageContentView) {
        return;
    }
    
    self.messageContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, self.mj_h - 64)];
    self.messageContentView.backgroundColor = BackGroundColor;
    [self addSubview:self.messageContentView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = title;
    tipLabel.textColor = kUIColorFromRGB(0x666666);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:15.f];
    [self.messageContentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];

    if (imgName.length > 0) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"22fd4b86e80cfce3aabe4bad99f5965d"];
        [self.messageContentView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(tipLabel.mas_top).offset(-10);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    
    if (btnTiltle.length > 0) {
        UIButton *btnJoin = [[UIButton alloc] init];
        [btnJoin setBackgroundColor:[UIColor whiteColor]];
        [btnJoin setTitle:btnTiltle forState:UIControlStateNormal];
        [btnJoin setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
        btnJoin.titleLabel.font = [UIFont systemFontOfSize:16.f];
        btnJoin.layer.cornerRadius = 2;
        btnJoin.layer.masksToBounds = YES;
        btnJoin.layer.borderColor = kUIColorFromRGB(0xbbbbbb).CGColor;
        btnJoin.layer.borderWidth = 0.1;
        [self.messageContentView addSubview:btnJoin];
        
        [btnJoin addTarget:self action:@selector(btnJoinClick) forControlEvents:UIControlEventTouchUpInside];
        
        [btnJoin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tipLabel.mas_bottom).offset(30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(255);
            make.height.mas_equalTo(42);
        }];
    }
}

- (void)btnJoinClick {
    self.btnClick();
}

- (UIView *)messageContentView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMessageContentView:(UIView *)messageContentView {
        objc_setAssociatedObject(self, @selector(messageContentView), messageContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())btnClick {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBtnClick:(void (^)())btnClick {
            objc_setAssociatedObject(self, @selector(btnClick), btnClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
