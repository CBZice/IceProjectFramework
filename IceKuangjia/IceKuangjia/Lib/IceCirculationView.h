//
//  IceCirculationView.h
//  IceScrollView
//
//  Created by sanmi on 16/8/22.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IceCirculationView;

@protocol IceCirculationViewDelegate <NSObject>

@optional
/**
    用于获取当前是哪张图片，可添加点击事件
 */
- (void)iceCirculationView:(IceCirculationView *)iceCirculationView whichPicureBeChanged:(NSInteger)index;

@end

@interface IceCirculationView : UIView

/**
    分页控制器
 */
@property (nonatomic, strong) UIPageControl *pageControl;
/**
    占位图
 */
@property (nonatomic, copy) NSString *placeHolder;
/**
    界面停留时间
 */
@property (nonatomic, assign) CGFloat animationDelay;
/**
    当前页数
 */
@property (nonatomic, assign) NSInteger currectPage;
/**
 初始化方法，在imageArr，可以放入本地图片与网络图片俩中
 */
-(instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)imageArr;

@property (nonatomic, weak) id<IceCirculationViewDelegate> delegate;

- (void)stopTimer;

@end
