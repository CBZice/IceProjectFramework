//
//  EBPageView.h
//  ExpressBusiness
//
//  Created by 陈冰泽 on 2018/8/2.
//  Copyright © 2018年 hairong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EBPageViewTypeMain,     // 主界面
    EBPageViewTypeMinor,    // 次界面
} EBPageViewType;

@interface EBPageView : UIView

@property (nonatomic, assign) EBPageViewType type;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles subViews:(NSArray *)subViews;

@property (nonatomic, assign) NSInteger currectPage;

@end
