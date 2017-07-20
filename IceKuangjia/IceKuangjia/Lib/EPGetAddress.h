//
//  EPGetAddress.h
//  ExpressPay
//
//  Created by shoujizhifu on 2017/7/14.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getAddressBlock)(NSString *address, double lnt, double lat);

@interface EPGetAddress : NSObject

- (void)getAddress:(getAddressBlock)address;

+ (instancetype)shareAddressBlock:(getAddressBlock)address;

@end
