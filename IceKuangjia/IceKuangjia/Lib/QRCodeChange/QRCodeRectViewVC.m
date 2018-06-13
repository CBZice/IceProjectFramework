//
//  QRCodeRectViewVC.m
//  曲线图
//
//  Created by shoujizhifu on 2017/7/31.
//  Copyright © 2017年 whq. All rights reserved.
//

#import "QRCodeRectViewVC.h"
#import "VideoDeviceAuthorization.h"
#import "QRCodeView.h"
#import "CutOutClearView.h"
#import <SVProgressHUD/SVProgressHUD.h>

/**
 *  UIScreen width.
 */
#define  Width   [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height.
 */
#define  Height  [UIScreen mainScreen].bounds.size.height

@interface QRCodeRectViewVC()<QRCodeViewDelegate>

@property (nonatomic, strong) UIButton   *lightButton;
@property (nonatomic, strong) UIView     *blackView;
@property (nonatomic, strong) QRCodeView *codeView;

// 是否连接
@property (nonatomic, assign) BOOL haveConnect;

@end

@implementation QRCodeRectViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Background view.
    self.blackView                 = [[UIView alloc] initWithFrame:self.view.bounds];
    self.blackView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:1];
    [self.view addSubview:self.blackView];
    
    // ImageView.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width - 90.f, Width - 90.f)];
    imageView.image        = [UIImage imageNamed:@"最外层"];
    imageView.center       = CGPointMake(self.view.center.x, self.view.center.y + 64/2.0);
    [self.view addSubview:imageView];
    
    // Cutout mask view.
    CutOutClearView *maskView = [[CutOutClearView alloc] initWithFrame:self.view.bounds];
    maskView.paths            = @[[UIBezierPath bezierPathWithRect:imageView.frame]];
    
    // Code view.
    self.codeView                             = [[QRCodeView alloc] initWithFrame:self.view.bounds];
    self.codeView.alpha                       = 0;
    self.codeView.delegate                    = self;
    self.codeView.interestArea                = imageView.frame;
    self.codeView.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.codeView.contentView.maskView        = maskView;
    [self.view addSubview:self.codeView];
    [self.view bringSubviewToFront:imageView];
    
    [self setRightNav];
}

- (void)QRCodeView:(QRCodeView *)codeView codeString:(NSString *)codeString {
    NSLog(@"QRCode = %@", codeString);
    if (!_haveConnect) {
        if (_qrHaveResult) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            [_codeView stop];
            _qrHaveResult(codeString);
        }
        _haveConnect = YES;
    }
}

#pragma mark - Button event.

- (void)buttonEvent:(UIButton *)button {
    
    if (self.codeView.torchMode == AVCaptureTorchModeOff) {
        
        self.codeView.torchMode = AVCaptureTorchModeOn;
        [button setImage:[UIImage imageNamed:@"newbarcode_light_on"] forState:UIControlStateNormal];
        
    } else if (self.codeView.torchMode == AVCaptureTorchModeOn) {
        
        self.codeView.torchMode = AVCaptureTorchModeOff;
        [button setImage:[UIImage imageNamed:@"newbarcode_light_off"] forState:UIControlStateNormal];
    }
}


#pragma mark - System method.

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.codeView.isRunning == NO) {
        
        if ([self.codeView start]) {
            
            [UIView animateWithDuration:1.f animations:^{
            
                self.codeView.alpha    = 1.f;
                self.lightButton.alpha = 1.f;
                self.blackView.alpha   = 0.f;
            }];
            
        } else {
            [SVProgressHUD showInfoWithStatus:@"摄像头不可用"];
        }
    }
}

- (void)setRightNav {
    // lightButton.
    UIImage  *image       = [UIImage imageNamed:@"newbarcode_light_off"];
    UIButton *lightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
    [lightButton setImage:image forState:UIControlStateNormal];
    [lightButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [lightButton.imageView setContentMode:UIViewContentModeCenter];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lightButton];
    self.lightButton       = lightButton;
    self.lightButton.alpha = 0.f;
}


@end
