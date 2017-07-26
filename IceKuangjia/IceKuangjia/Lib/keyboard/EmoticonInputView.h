//
//  EmoticonInputView.h
//  weibotext5.26
//
//  Created by shoujizhifu on 2017/5/31.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EmoticonStatusComposeEmoticonViewDelegate <NSObject>
@optional
- (void)emoticonInputDidTapText: (NSString *)text;
- (void)emoticonInputDidTapBackspace;
@end

/// 表情输入键盘
@interface EmoticonInputView : UIView
@property (nonatomic, weak) id<EmoticonStatusComposeEmoticonViewDelegate> delegate;
+ (instancetype)sharedView;
@end
