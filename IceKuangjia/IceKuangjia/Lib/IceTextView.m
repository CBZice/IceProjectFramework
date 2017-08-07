//
//  IceTextView.m
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/8/7.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import "IceTextView.h"

@interface IceTextView()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation IceTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.placeHolderLabel];
        [self setValue:self.placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return self;
}

-(void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    _placeHolderLabel.text = placeHolder;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _placeHolderLabel.frame = CGRectMake(4, 7, self.width, self.height);
    [_placeHolderLabel sizeToFit];
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    }
    return _placeHolderLabel;
}


@end
