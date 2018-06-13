//
//  FirstViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "IceNavigationController.h"
#import "IceCirculationView.h"
#import "ShowPhotoVC.h"


@interface FirstViewController ()<IceCirculationViewDelegate>

@property (nonatomic, strong) IceCirculationView *iceCircleView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WeekSelf
    [self rightBtnItemWithimgNames:@[@"nav_item_back",@"nav_item_back",@"nav_item_back"] block:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    }];
    
    [self leftBtnItemWithTitle:@"呵呵" block:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
        [weSelf.navigationController pushViewController:[ShowPhotoVC new] animated:YES];
    }];
    
    _iceCircleView = [[IceCirculationView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 200) Images:@[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3424226810,3788025634&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1984060613,3473764934&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2586472413,677685330&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2261844264,1398222573&fm=23&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2801782160,3456854724&fm=23&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2348585824,784672926&fm=23&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=967919111,969882314&fm=23&gp=0.jpg"]];
    _iceCircleView.delegate = self;
    [self.view addSubview:_iceCircleView];
    
    [self createJWP];
}

- (void)createJWP {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"goods_name":@"iphoneX"} options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    jsonString = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_key"] = @"ANDROID_TEST";
    params[@"data"] = jsonString;
    params[@"name"] = @"goods.get";
    params[@"timestamp"] = @"2018-05-24 13:57:56";
    params[@"version"] = @"1.0";
    NSString *key = @"ANDROID_MERCHANT_TEST";
    NSArray *keyArr = @[@"app_key", @"data", @"name", @"timestamp", @"version"];
    NSMutableString *signStr = [NSMutableString string];
    for (int i = 0; i < keyArr.count; i++) {
        if (i == 0) {
            [signStr appendString:key];
        }
        [signStr appendString:keyArr[i]];
        [signStr appendString:params[keyArr[i]]];
        if (i == keyArr.count - 1) {
            [signStr appendString:key];
        }
    }
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)iceCirculationView:(IceCirculationView *)iceCirculationView whichPicureBeChanged:(NSInteger)index{
    NSLog(@"%ld", (long)index);
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [_iceCircleView stopTimer];
}

@end
