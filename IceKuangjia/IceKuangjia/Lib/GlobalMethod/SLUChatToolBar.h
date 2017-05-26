//
//  SLUChatToolBar.h
//  frame测试
//
//  Created by sanmi on 16/7/18.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLUChatToolBarDelegate <NSObject>

- (void)chatToolBarWhichBeChoose:(int)chooseTag title:(NSString *)chooseTitle;

@end

@interface SLUChatToolBar : UIView

@property (nonatomic, weak) id<SLUChatToolBarDelegate> delegate;

/**
    supView传入让其出现的view
 */
- (instancetype)initWithSupView:(UIView *)supView;
//显示
- (void)show;

//消失
- (void)cancel;

@end
