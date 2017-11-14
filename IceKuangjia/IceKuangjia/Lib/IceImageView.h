//
//  IceImageView.h
//  放大图片
//
//  Created by sanmi on 16/11/3.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IceImageViewDelegate <NSObject>

@optional
- (void)imageView:(UIImageView *)imageView LongPressGesState:(UIGestureRecognizerState)state;

@end

@interface IceImageView : UIImageView

/**
 点击手势，默认开启
 */
@property (nonatomic, assign) BOOL openTapGes;
/**
 长按手势，默认开启
 */
@property (nonatomic, assign) BOOL openLongPressGes;

@property (nonatomic, weak) id<IceImageViewDelegate> delegate;

@end
