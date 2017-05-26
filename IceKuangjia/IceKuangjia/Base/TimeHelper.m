//
//  TimeHelper.m
//  smsapns
//
//  Created by cooptec on 16/3/21.
//  Copyright © 2016年 cooptec. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper
+ (NSString *)getDate
{
    return [TimeHelper getDateString:[NSDate date]];
}

+ (NSString *)getDateString:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd H:mm:ss"];
    
    return [form stringFromDate:date];
}

+ (NSDate *)getDateWithDateTimeString:(NSString *)string
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd H:mm:ss"];
    return [form dateFromString:string];
}
+ (CGFloat)timeIntervalWithDateString:(NSString *)dateString
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd H:mm:ss"];
    
    NSDate *date = [form dateFromString:dateString];
    return [date timeIntervalSinceNow];
}
+ (NSString *)getDateWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd"];
    
    return [form stringFromDate:date];
}
+ (NSString *)getTimeAndSecWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"H:mm:ss"];
    
    return [form stringFromDate:date];
}

+ (NSString *)getTimeWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"HH:mm"];
    
    return [form stringFromDate:date];
}
+ (NSDate *)getDateWithDateString:(NSString *)dateString
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd"];
    
    return [form dateFromString:dateString];
}
+ (NSDate *)getDateWithTimeString:(NSString *)timeString
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"H:mm:ss"];
    return [form dateFromString:timeString];
}

+ (NSDate *)getDateWithSeplineDateTimeString:(NSString *)string
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy/MM/dd H:mm:ss"];
    
    NSDate *date = [form dateFromString:string];
    return date;
}

+ (NSString *)getNoSecStringWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd H:mm"];
    
    
    return [form stringFromDate:date];
}
+ (NSDate *)getNoSecDateWithDateString:(NSString *)dateString
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy-MM-dd H:mm"];
    
    
    return [form dateFromString:dateString];
}
+ (NSString *)getYueAndDayStringWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"MM/dd"];

    return [form stringFromDate:date];
}
@end
