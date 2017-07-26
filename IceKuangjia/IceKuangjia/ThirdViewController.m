//
//  ThirdViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "ThirdViewController.h"
#import "WBEmoticonInputView.h"
#import "WBStatusHelper.h"
#import "WBStatusComposeTextParser.h"
#import <YYKit/UIView+YYAdd.h>

@interface ThirdViewController ()<YYTextViewDelegate,YYTextKeyboardObserver,WBStatusComposeEmoticonViewDelegate>
@property (nonatomic, strong) UIButton *emotionBtn;
@property (nonatomic, strong) YYTextView *textView;

@end

@implementation ThirdViewController
- (void)dealloc {
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    
    _textView = [YYTextView new];
    if (kSystemVersion < 7) _textView.top = 0;
    _textView.size = CGSizeMake(self.view.width, self.view.height);
    _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
    _textView.contentInset = UIEdgeInsetsMake(64, 0, 200, 0);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = 49;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.textParser = [WBStatusComposeTextParser new];
    _textView.delegate = self;
    _textView.inputAccessoryView = [UIView new];
    [self.view addSubview:_textView];
    
    _emotionBtn = [[UIButton alloc] init];
    _emotionBtn.size = CGSizeMake(40, 40);
    _emotionBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    _emotionBtn.bottom = self.view.height;
    [_emotionBtn addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_emotionBtn];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [_textView becomeFirstResponder];
}

- (void)touchBtn{
    if (_textView.inputView) {
        _textView.inputView = nil;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
        WBEmoticonInputView *v = [WBEmoticonInputView sharedView];
        v.delegate = self;
        _textView.inputView = v;
        [_textView reloadInputViews];
        [_textView becomeFirstResponder];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [_emotionBtn setImage:[WBStatusHelper imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark @protocol YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        _emotionBtn.bottom = CGRectGetMinY(toFrame);
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _emotionBtn.bottom = CGRectGetMinY(toFrame);
        } completion:NULL];
    }
}

#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [_textView replaceRange:_textView.selectedTextRange withText:text];
    }
}
- (void)emoticonInputDidTapBackspace {
    [_textView deleteBackward];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_textView resignFirstResponder];
}


@end
