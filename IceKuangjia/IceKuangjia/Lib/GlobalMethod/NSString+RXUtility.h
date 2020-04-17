//
//  NSString+RXUtility.h
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/4/17.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (RXUtility)



- (NSString *)rx_hiddenMobileFormatString;


- (BOOL)rx_isChinaMobileFormat;
- (NSString *)rx_md5 NS_DEPRECATED(1_4, 1_4, 1_4, 1_4, "Use -rx_transform_MD5 instead.");
// 是否是纯数字的字符串
- (BOOL)rx_isPureInt;
// 大于零的整数
- (BOOL)rx_isNoZeorIntValue;
// 是否包含表情
- (BOOL)rx_containEmoji;
// 是否是中文，只要包含中文就是中文
- (BOOL)rx_isChinese;


- (BOOL)rx_isTwoDoubleIntValueWithString:(NSString *)str;

- (BOOL)rx_isValidateEmail;

- (NSString *)rx_transformToPinyin NS_DEPRECATED(1_4, 1_4, 1_4, 1_4, "Use -rx_transform_Phoneticize instead.");

// 得到一个对象, 如果是字符串的长度是否为0,如果为0,返回空字符串
+ (NSString *)rx_validStringWithObj:(id)obj;




#pragma mark - Override NSString Method
// __NSCFNString 如果不包含target有时会直接崩溃
// http://blog.sina.com.cn/s/blog_8764c3140100wxc3.html
// 没有发生替换的时候有可能出现问题
- (NSString *)rx_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;



#pragma mark - Phoneticize
- (NSString *)rx_transform_Phoneticize;

#pragma mark - Base64 Encode/Decode
- (NSString *)rx_transform_Base64Encode;
- (NSString *)rx_transform_Base64Decode;

#pragma mark - URL Encode/Decode
- (NSString *)rx_transform_URLEncode;
- (NSString *)rx_transform_URLDecode;

#pragma mark - MD5
- (NSString *)rx_transform_MD5;

//Base64字符串转UIImage图片：
- (UIImage *)rx_transform_Base64Image;

#pragma mark - AES Encrypt/Decrypt
// http://www.cnblogs.com/xzjxylophone/p/5462673.html
- (NSString *)rx_transform_AES128EncryptWithKey:(NSString *)key;
- (NSString *)rx_transform_AES128DecryptWithKey:(NSString *)key;



@end
