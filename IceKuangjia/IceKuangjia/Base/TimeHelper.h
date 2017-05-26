//
//  TimeHelper.h
//  smsapns
//
//  Created by cooptec on 16/3/21.
//  Copyright © 2016年 cooptec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TimeHelper : NSObject
+ (NSString *)getDate;
+ (NSString *)getDateString:(NSDate *)date;
+ (NSDate *)getDateWithDateTimeString:(NSString *)string;
+ (CGFloat)timeIntervalWithDateString:(NSString *)dateString;
+ (NSDate *)getNoSecDateWithDateString:(NSString *)dateString;
+ (NSString *)getTimeAndSecWithDate:(NSDate *)date;
+ (NSString *)getDateWithDate:(NSDate *)date;
+ (NSString *)getTimeWithDate:(NSDate *)date;
+ (NSDate *)getDateWithDateString:(NSString *)dateString;
+ (NSDate *)getDateWithTimeString:(NSString *)timeString;
// 处理带/的时间用的
+ (NSDate *)getDateWithSeplineDateTimeString:(NSString *)string;

+ (NSString *)getNoSecStringWithDate:(NSDate *)date;

+ (NSString *)getYueAndDayStringWithDate:(NSDate *)date;
@end
