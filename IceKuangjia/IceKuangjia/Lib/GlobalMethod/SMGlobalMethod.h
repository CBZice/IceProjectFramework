//
//  SMGlobalMethod.h
//  Smios
//
//  Created by hao on 15/11/27.
//  Copyright (c) 2015年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMGlobalMethod : NSObject
//date转时间yyyyMMdd
+(NSString *)getTimeFromTimeDaY:(NSDate *)date;
//时间戳转时间
+(NSString *)getTimeFromTimeSp:(NSString *)timeSp;
//时间戳转时间
+(NSString *)getTimeFromShortTimeSpY:(NSString *)shortTimeSp;
//时间戳转时间yyyy-MM-dd
+(NSString *)getTimeFromShortTimeSp:(NSString *)shortTimeSp;
//date转时间
+(NSString *)getTimeFromTimeDa:(NSDate *)date;
+(NSString *)getTimeFromShortTimeDa:(NSDate *)date;
//时间文本转dateShort
+(NSDate *)getTimeDateFromeShortTimeStryy:(NSString *)timeStr;
//将时间转为时间戳
//+ (NSString *)getTimetroWith:
//获取当前时间戳
+(NSString *)getTimeSp;
//时间文本转date
+(NSDate *)getTimeDateFromeTimeStr:(NSString *)timeStr;
+(NSDate *)getTimeDateFromeShortTimeStr:(NSString *)timeStr;
//date转时间戳
+(NSString *)getTimeSpFromeTimeDate:(NSDate *)date;
//时间文本转date(YYYYMMddHHmm)
+ (NSDate *)getTimeDateFromeTimeStrWithYYY:(NSString *)timeStr;
//date转时间yyyyMMddHHmm
+(NSString *)getTimeFromTimeDaYY:(NSDate *)date;

//自动消失的提示框
+(void)showMessage:(NSString *)message;

#pragma mark-- 正则判断
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//电话号验证
+ (BOOL)validateIsMobileNumber:(NSString *)mobileNum;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//邮编
+ (BOOL) validatePostcode:(NSString *)nickname;

#pragma mark- 各类型数据转换
//字典转data
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
//字典转json串
+(NSString*)returnDictionaryToJson:(NSDictionary *)dic;
//转换html标签
+(NSString *)filterHTML:(NSString *)str;

#pragma mark-- 清理缓存
/** 获取缓存大小 */
#define __CACHES_SIZE(folderName) [SMGlobalMethod getCacheSizeFromFolder:(folderName)]

/** 清除缓存 */
#define __CLEAN_CACHES(folderName) [SMGlobalMethod clearCacheFromFolder:(folderName)]
/**
 *  获取caches下folderName文件夹缓存大小(Caches/folderName)
 *
 *  @param folderName 缓存文件夹
 *
 *  @return 返回缓存大小
 */
+ (float)getCacheSizeFromFolder:(NSString *)folderName;


/**
 *  清除caches下folderName文件夹缓存大小(Caches/folderName)
 *
 *  @param folderName 缓存文件夹
 */
+ (void)clearCacheFromFolder:(NSString *)folderName;

// 打电话
+ (void)phoneSomeone:(NSString *)phoneNum;
// 发短信
+ (void)messageSomeone:(NSString *)phoneNum;

@end
