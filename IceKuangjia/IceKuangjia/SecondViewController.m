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
#import <WebKit/WebKit.h>
#import <AFNetworking/AFNetworking.h>
#import "NSString+RXUtility.h"
#import "AES128Util.h"


@interface SecondViewController ()<WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

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
//    [self jwtRequest];
}

- (void)jwtRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://171.16.2.36:8088/merchant/api/ssl"]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"Bearer a873259a8fd3f62b9a8b95e32badec3047308789a4448f24f568292b0d4bce783d6428d96f08612f22e0324ad0175a9c5007cf777507c724fbde62af120788a47cd1f87ce1832b5064c6fb12a2a8bf43b2334a959adf64ce4da98d429efa7060838394d62d488c1d2d8551296d97863a843378ae822cbdd4c3b960e20dcad701f98d8a4167e44d296503a655160fdd6b36c4eb2c27170b1e13240f2bd51855dc1ab04566b22005b949b95786e61ffe81f267f07192638403a2942519a68a5d8d8396a2ed88d5d7abaff223ea8a8dae3d275cd68911c6a61fcf5ec964c5936a12" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *jsonString1 = @"b96e7328ad6d33c8c62403ef4aaf4ac5e26997c2727efd6b972972103a464edb65975b46502702acba22c3791314924bfe579a791059b1ad21cdfc093d4b73ab719a70e8bc755838c58543acc35365eb8a26480e0b3c7b0c56bd2a8d5c66c717739b3ea8c69074a41a8ca0dd72ce099daab197e0cdfdd4f37bdaa0519dd8d90891ce00de4ac76e958700870bb323723496ec304c573c8b477c8a66bedf2eec629418407742bd646263490bd2d4d8c715abdaff2fab0d273ebf48b6cc31db5ec5db8902149cf17287eda0f8945ccaedf13a1dfe9965bbd36369167152959495d9c5f39c9e6c64caa1eadfaa9df230df6b33d365659cbe1bd02a11a8c4fd9d41b9";
    
    NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:jsonData];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:kCFStringEncodingUTF8];
        NSString *resultStr = [AES128Util AES128Decrypt:str key:@"HAIRONG_TEST"];
        NSLog(@"%@", [AES128Util AES128Decrypt:str key:@"HAIRONG_TEST"]);
        data = [resultStr dataUsingEncoding:kCFStringEncodingUTF8];
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

- (void)afnetWorking {
    
    NSString *jsonString = [self convertToJsonData:@{@"account":@"15130141616",@"pagerNo":@(1),@"pagerSize":@(10)}];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_key"] = @"ANDROID_TEST";
    params[@"data"] = jsonString;
    
    params[@"name"] = @"transaction.getPosSettlement";
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
    NSLog(@"%@", [SMGlobalMethod md5:signStr]);
    NSLog(@"%@", [self convertToJsonData1:params]);
    NSString *jsonString2 = [self convertToJsonData1:params];
    jsonString2 = [AES128Util AES128Encrypt:jsonString2 key:@"HAIRONG_TEST"];
    NSData *jsonData = [jsonString2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", jsonData);
    
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/plain", nil];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://171.16.2.36:8088/merchant/api/ssl"]];
    [request setHTTPMethod:@"POST"];
        [request setValue:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyTCIsImV4cCI6MTUzMzYxMzg5OSwiaWF0IjoxNTMzNjA2Njk5LCJ1c2VybmFtZSI6ImppbSJ9.FXyZJSajST0AGO-q8T4SHML09xhXpW08SkOIznu4Qek" forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:jsonData];
    
    // 2.发送请求
    [[mgr dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:kCFStringEncodingUTF8];
        NSString *resultStr = [AES128Util AES128Decrypt:str key:@"HAIRONG_TEST"];
        NSLog(@"%@", [AES128Util AES128Decrypt:str key:@"HAIRONG_TEST"]);
        responseObject = [resultStr dataUsingEncoding:kCFStringEncodingUTF8];
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //处理你的数据
            }
        } else {
            
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}

-(NSString *)convertToJsonData1:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (void)getOn {
    NSArray *arr = @[@(1), @(2), @(3)];
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

- (void)webView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 200, WIDTH, 500)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://v.douyu.com/show/2V0JMVK0g46WRY5k"]]];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    QRCodeRectViewVC *qrCodeVC = [QRCodeRectViewVC new];
//    [self.navigationController pushViewController:qrCodeVC animated:YES];
    
    [self afnetWorking];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSString *requestString = [[webView.URL absoluteString] stringByRemovingPercentEncoding];
    NSLog(@"%@", requestString);
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
