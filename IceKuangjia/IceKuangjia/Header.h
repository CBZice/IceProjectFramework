//
//  Header.h
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#ifndef Header_h
#define Header_h



//屏幕宽
#define WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define isIphoneX           ((int)[[UIApplication sharedApplication] statusBarFrame].size.height) == 44 ? true : false
#define NavHeight           ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.0)
#define TabbarHeight        ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define WeekSelf __weak typeof(self) weSelf = self;

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#define CurrectVerion  (NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];\
                        return infoDic[@"CFBundleShortVersionString"];)



#endif /* Header_h */
