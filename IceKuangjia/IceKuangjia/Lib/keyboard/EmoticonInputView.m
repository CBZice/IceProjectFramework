//
//  EmoticonInputView.m
//  weibotext5.26
//
//  Created by shoujizhifu on 2017/5/31.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "EmoticonInputView.h"
#import "WBStatusHelper.h"
#import "EmotionModel.h"
//#import <YYKit.h>
#import <YYKit/YYKit.h>

#define kViewHeight         216
#define kToolbarHeight      37
#define kOneEmotionHeight   50
#define kOnePageCount       20

@interface EmoticonCell : UICollectionViewCell<UITableViewDataSource>

@property (nonatomic, strong) Emoticon *emoticon;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation EmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _imageView = [UIImageView new];
    _imageView.size = CGSizeMake(32, 32);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    return self;
}

- (void)setEmoticon:(Emoticon *)emoticon {
    if (_emoticon == emoticon) return;
    _emoticon = emoticon;
    [self updateContent];
}

- (void)setIsDelete:(BOOL)isDelete {
    if (_isDelete == isDelete) return;
    _isDelete = isDelete;
    [self updateContent];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateLayout];
}

- (void)updateLayout {
    _imageView.center = CGPointMake(self.width / 2, self.height / 2);
}

- (void)updateContent {
    [_imageView cancelCurrentImageRequest];
    _imageView.image = nil;
    
    if (_isDelete) {
        _imageView.image = [WBStatusHelper imageNamed:@"compose_emotion_delete"];
    }else if (_emoticon) {
        if (_emoticon.type == EmoticonTyoeEmoji) {
            NSNumber *num = [NSNumber numberWithString:_emoticon.code];;
            NSString *str = [NSString stringWithUTF32Char:num.unsignedIntValue];
            if (str) {
                UIImage *img = [UIImage imageWithEmoji:str size:_imageView.width];
                _imageView.image = img;
            }
        }else if (_emoticon.group.groupId && _emoticon.png) {
            NSString *pngPath = [[WBStatusHelper emoticonBundle] pathForResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupId];
            if (!pngPath) {
                NSString *addBundlePath =  [[WBStatusHelper emoticonBundle].bundlePath stringByAppendingPathComponent:@"additional"];
                NSBundle *addBundle = [NSBundle bundleWithPath:addBundlePath];
                pngPath = [addBundle pathForScaledResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupId];
            }
            if (pngPath) {
                [_imageView setImageWithURL:[NSURL fileURLWithPath:pngPath] options:YYWebImageOptionIgnoreDiskCache];
            }
        }
    }
}
@end

@protocol EmoticonScrollViewDelegate <NSObject>

- (void)emoticonScrollViewDidTapCell: (EmoticonCell *)cell;

@end

@interface EmoticonScrollView : UICollectionView

@end
@implementation EmoticonScrollView {
    NSTimeInterval *_touchBegainTime;
    BOOL _touchMoved;
    UIImageView *_magnifier;
    UIImageView *_magnifierContent;
    __weak EmoticonCell *_currentMagnifierCell;
    NSTimer *_backspaceTimer;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.canCancelContentTouches = NO;
    self.multipleTouchEnabled = NO;
    _magnifier = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"emoticon_keyboard_magnifier"]];
    _magnifierContent = [UIImageView new];
    _magnifierContent.size = CGSizeMake(40, 40);
    _magnifierContent.centerX = _magnifier.width / 2.0;
    [_magnifier addSubview:_magnifierContent];
    _magnifier.hidden = YES;
    [self addSubview:_magnifier];
    return self;
}

@end


@implementation EmoticonInputView

@end
