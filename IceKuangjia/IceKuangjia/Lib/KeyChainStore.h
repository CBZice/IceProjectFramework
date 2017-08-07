//
//  KeyChainStore.h
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/8/2.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;

@end
