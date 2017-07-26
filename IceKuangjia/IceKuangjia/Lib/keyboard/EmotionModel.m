//
//  EmotionModel.m
//  weibotext5.26
//
//  Created by shoujizhifu on 2017/5/31.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "EmotionModel.h"

@implementation Emoticon : NSObject

+ (NSArray *)modelPropertyBlacklist {
    return @[@"group"];
}

@end


@implementation EmoticonGroup

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupId" : @"id",
             @"nameCN"  : @"group_name_cn",
             @"nameEN"  : @"group_name_en",
             @"nameTW"  : @"group_name_tw",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"emotions" : [Emoticon class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_emoticons enumerateObjectsUsingBlock:^(Emoticon * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.group = self;
    }];
    return YES;
}

@end
