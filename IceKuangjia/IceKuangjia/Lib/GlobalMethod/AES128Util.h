//
//  AES128Util.h
//  IceKuangjia
//
//  Created by 陈冰泽 on 2018/8/7.
//  Copyright © 2018年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Util : NSObject
+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;


+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;
@end
