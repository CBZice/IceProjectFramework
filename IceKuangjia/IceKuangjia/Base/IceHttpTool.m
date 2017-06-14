//
//  IceHttpTool.m
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/6/14.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import "IceHttpTool.h"

@implementation IceHttpTool

#pragma mark - 单例

+ (instancetype)sharedTool{
    static dispatch_once_t onceToken;
    static IceHttpTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc]init];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        requestSerializer.timeoutInterval = 10;
        ///我们项目是把access_token（后台验证用户省份标识）放在了请求头里,有的项目是放在了请求体里,视实际情况而定
//        [requestSerializer setValue:[SDHSDataCache getToken] 
        instance.requestSerializer = requestSerializer;
        
        //        ///1.强制更换AFN数据解析类型 只支持一下添加的数据类型 AFN自带的就没有了 如果AFN新增了数据解析类型 这里也没有变化 所以有下面2方法 向原有可解析数据类型添加较好
        //        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];8k9K10
        
        ///2.获取AFN原有的数据解析类型 然后新增一些响应解析器能够接受的数据类型
        NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
        [acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",@"text/plain",@"text/xml"]];
        instance.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        
    });
    return instance;
}

#pragma mark - 自定义GET

- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符发生崩溃
    [self GET:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

#pragma mark - 自定义POST

- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符 发生崩溃
    [self POST:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        ////将接收回来的数据转成UTF8的字符串，然后取出格式占位符 加上个转义符后才能让数据进行转换 否则转换失败
        //        NSString*jsonString = [[NSString alloc] initWithBytes:[responseObject bytes]length:[responseObject length]encoding:NSUTF8StringEncoding];
        //        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
        //        NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - 上传数据

- (void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray<IceUploadParam *> *)uploadParams success:(void (^)())success failure:(void (^)(NSError *))failure {
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (IceUploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 下载数据

- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)())progress success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [self downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

@end
