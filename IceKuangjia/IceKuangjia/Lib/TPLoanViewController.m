//
//  TPLoanViewController.m
//  TobaccoPartner
//
//  Created by shoujizhifu on 2017/2/13.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "TPLoanViewController.h"

@interface TPLoanViewController () <UIWebViewDelegate>{
    CGFloat webY;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, assign) BOOL canBack;

@end

@implementation TPLoanViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!_push) {
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
    }
    [self cleanCache];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_push) {
        [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)cleanCache {
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies])
        
    {
        
        [storage deleteCookie:cookie];
        
    }
    
    //    清除webView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGroundColor;
    webY = 20;
    if (_push) {
        webY = NavHeight;
    }
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, webY, self.view.frame.size.width, self.view.frame.size.height-webY)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView setScalesPageToFit:YES];

    
    _urlStr = [_urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _urlStr = [_urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@", _urlStr);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    
    
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, webY, 0, 10)];
    _progressView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_progressView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(selfTimer) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _canBack = YES;
    });
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回拷贝18"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popToOther)];
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.webView.scrollView setContentInset:UIEdgeInsetsZero];
}

- (void)selfTimer {
    if (_progressView.frame.size.width < WIDTH-20) {
        _flag++;
        [UIView animateWithDuration:0.1 animations:^{
            _progressView.frame = CGRectMake(0, webY, _flag*20, 3);
        }];
    }else {
        [self.timer invalidate];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSString * requestString = [[request URL] absoluteString];
    
//    NSString * headerString = (NSString *)[request allHTTPHeaderFields][@"Referer"];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"requestString = %@", requestString);
    NSLog(@"%@", [request allHTTPHeaderFields]);
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
//    if ([_pageName isEqualToString: @"POS报件"]) {
//    NSLog(@"canGoBack == %d", webView.canGoBack);
//        if ([requestString isEqualToString:@"about:blank"] && _canBack && [headerString isEqualToString:_urlStr]) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//            [webView stopLoading];
//        }
//    } else {
        if ([requestString isEqualToString:@"about:blank"] && _canBack) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [webView stopLoading];
        }
//    }

    
    if ([requestString isEqualToString:@"about:blank"]) {
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.timer invalidate];
    [_progressView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"requestString = %@", error);
    [self.timer invalidate];
    [_progressView removeFromSuperview];
    [SMGlobalMethod showMessage:error.userInfo[@"NSLocalizedDescription"]];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
}
- (void)timerMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToOther{
    if (_webView.canGoBack) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

