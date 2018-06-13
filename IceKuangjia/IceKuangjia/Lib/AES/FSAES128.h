//
//  FSAES128.h
//  IceKuangjia
//
//  Created by 陈冰泽 on 2018/6/1.
//  Copyright © 2018年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSAES128 : NSObject

/**
 *  加密
 *
 *  @param string 需要加密的string
 *
 *  @return 加密后的字符串
 */
+ (NSString *)AES128EncryptStrig:(NSString *)string;

/**
 *  解密
 *
 *  @param string 加密的字符串
 *
 *  @return 解密后的内容
 */
+ (NSString *)AES128DecryptString:(NSString *)string;
@end
