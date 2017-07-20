//
//  ColorHeader.h
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/7/20.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

//随机色
#define Random_color [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

//颜色
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define BackGroundColor     kUIColorFromRGB(0xf3f3f3)

#define Line_Color          kUIColorFromRGB(0xdfdfdf)


#endif /* ColorHeader_h */
