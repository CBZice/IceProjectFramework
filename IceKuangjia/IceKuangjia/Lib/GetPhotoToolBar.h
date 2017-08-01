//
//  GetPhotoToolBar.h
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/8/1.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetPhotoToolBarDelegate;

@protocol GetPhotoToolBarDelegate <NSObject>

@optional
- (void)getPhoto:(UIImage *)iamge;

@end

typedef void(^PhotoBlock)(UIImage *image);

@interface GetPhotoToolBar : NSObject

+ (void)setPhotoDelegate:(id<GetPhotoToolBarDelegate>)delegate getPhotoBlcok:(PhotoBlock)block;

@end
