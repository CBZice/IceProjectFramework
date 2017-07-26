//
//  EmotionModel.h
//  weibotext5.26
//
//  Created by shoujizhifu on 2017/5/31.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, EmoticonTyoe) {
    EmoticonTypeImage = 0,      ///< 图片表情
    EmoticonTyoeEmoji = 1,      ///< Emoji表情
};


@class EmoticonGroup;
@interface Emoticon : NSObject

@property (nonatomic, copy) NSString *chs;      ///< 例如[吃惊]
@property (nonatomic, copy) NSString *cht;      ///< 例如[吃驚]
@property (nonatomic, copy) NSString *gif;      ///< 例如 d_chijing.gif
@property (nonatomic, copy) NSString *png;      ///< 例如 d_chijing.png
@property (nonatomic, copy) NSString *code;     ///< 例如 0x1f60d
@property (nonatomic, assign) EmoticonTyoe type;
@property (nonatomic, weak) EmoticonGroup *group;

@end


@interface EmoticonGroup : NSObject

@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *nameCN;
@property (nonatomic, copy) NSString *nameEN;
@property (nonatomic, copy) NSString *nameTW;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray<Emoticon *> *emoticons;

@end
