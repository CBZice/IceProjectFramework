

#import "HWHttpTool.h"

@implementation HWHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//   mgr.requestSerializer=[AFJSONRequestSerializer serializer];
   mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript", nil];

    [mgr GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    // 2.发送请求
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript", nil];
//    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.发送请求
    [mgr POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getJson:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript", nil];
    // 2.发送请求GET
    [mgr GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postJson:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript", nil];
    // 2.发送请求
    [mgr POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



@end


