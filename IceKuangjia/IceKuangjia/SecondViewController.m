//
//  SecondViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "SecondViewController.h"
#import "SLUChatToolBar.h"
#import "QRCodeRectViewVC.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *btn = [[UIView alloc] init];
//    btn.frame = CGRectMake(0, 200, 100, 100);
//    btn.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:btn];
//    
//    SLUChatToolBar *toolBar = [[SLUChatToolBar alloc] initWithSupView:btn];
//    [toolBar show];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    QRCodeRectViewVC *qrCodeVC = [QRCodeRectViewVC new];
    [self.navigationController pushViewController:qrCodeVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
