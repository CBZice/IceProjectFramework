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
#import <AFNetworking/AFNetworking.h>

#import "IceImageView.h"

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
    
//    [self createJWP];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconClick:) name:@"APPICONCLICK" object:nil];
    
    IceImageView *imgView = [[IceImageView alloc] init];
    imgView.frame = CGRectMake(100, 400, WIDTH - 200, 100);
    imgView.image = [UIImage imageNamed:@"mac_dog"];
    [self.view addSubview:imgView];
}

- (void)iconClick:(NSNotification *)noti {
    NSLog(@"%@", noti.object);
    [SMGlobalMethod showMessage:noti.object];
    self.navigationController.tabBarController.selectedIndex = (NSUInteger)noti.object;
}

- (void)createJWP {
    NSString *jsonString = [self convertToJsonData:@{@"id":@"1223_1"}];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_key"] = @"ANDROID_TEST";
    params[@"data"] = jsonString;
    
    params[@"name"] = @"transaction.getPosDetailsById";
    params[@"timestamp"] = @"2018-08-07 10:51:08";
    params[@"version"] = @"1.0";
    NSString *secret = @"ANDROID_MERCHANT_TEST";
    NSArray *keyArr = @[@"app_key", @"data", @"name", @"timestamp", @"version"];
    NSMutableString *signStr = [NSMutableString string];
    for (int i = 0; i < keyArr.count; i++) {
        if (i == 0) {
            [signStr appendString:secret];
        }
        [signStr appendString:keyArr[i]];
        [signStr appendString:params[keyArr[i]]];
        if (i == keyArr.count - 1) {
            [signStr appendString:secret];
        }
    }
    params[@"sign"] = [SMGlobalMethod md5:signStr];
//    params[@"format"] = @"json";
    NSLog(@"%@", [SMGlobalMethod md5:signStr]);
    [self convertToJsonData:params];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString1 = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString1 = @"b96e7328ad6d33c8c62403ef4aaf4ac5e26997c2727efd6b972972103a464edb65975b46502702acba22c3791314924bfe579a791059b1ad21cdfc093d4b73ab719a70e8bc755838c58543acc35365eb8a26480e0b3c7b0c56bd2a8d5c66c717739b3ea8c69074a41a8ca0dd72ce099daab197e0cdfdd4f37bdaa0519dd8d90891ce00de4ac76e958700870bb323723496ec304c573c8b477c8a66bedf2eec629418407742bd646263490bd2d4d8c715abdaff2fab0d273ebf48b6cc31db5ec5db8902149cf17287eda0f8945ccaedf13a1dfe9965bbd36369167152959495d9c5f39c9e6c64caa1eadfaa9df230df6b33d365659cbe1bd02a11a8c4fd9d41b9";
    jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *jsonData1 = [[self convertToJsonData:params] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", [self convertToJsonData:params]);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://171.16.2.36:8088/merchant/api"]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"Authorization" forHTTPHeaderField:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyTCIsImV4cCI6MTUzMzYxMzg5OSwiaWF0IjoxNTMzNjA2Njk5LCJ1c2VybmFtZSI6ImppbSJ9.FXyZJSajST0AGO-q8T4SHML09xhXpW08SkOIznu4Qek"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSString *result = [NEUSecurityUtil decodeBase64Data:[self convertToJsonData:params]];
        
        if (data) {
            //利用iOS自带原生JSON解析data数据 保存为Dictionary
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dict != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            } else {
                NSString *errorStr = [[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", errorStr);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            }
        }else{
            
        }
    }];
    [task resume];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    jsonString = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return jsonString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
-(void)iceCirculationView:(IceCirculationView *)iceCirculationView whichPicureBeChanged:(NSInteger)index{
    NSLog(@"%ld", (long)index);
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [_iceCircleView stopTimer];
}

@end
