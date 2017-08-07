//
//  ForthViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "ForthViewController.h"
#import "GetPhotoToolBar.h"
#import "IceTextView.h"

@interface ForthViewController ()<GetPhotoToolBarDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imgView.center = self.view.center;
    [self.view addSubview:_imgView];
    
    IceTextView *textView = [[IceTextView alloc] initWithFrame:CGRectMake(0, 80, WIDTH, 200)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = [UIColor blackColor];
    textView.placeHolder = @"这只是个测试";
    [self.view addSubview:textView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [GetPhotoToolBar setPhotoDelegate:self getPhotoBlcok:^(UIImage *image) {
        _imgView.image = image;
    }];
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
