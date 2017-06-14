//
//  IceHttpTool.h
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/6/14.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "IceHttpTool.h"

@class IceUploadParam;

@interface IceHttpTool : AFHTTPSessionManager

/**
 *  二次封装网络工具单例
 *
 */
+ (instancetype)sharedTool;

/**
 *  基于AFN二次封装GET方法
 *
 *  @URLString    相对路径
 *  @params       请求参数
 *  @finish      完成回调
 *
 */
- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

/**
 *   基于AFN二次封装POST方法
 *
 *  @URLString    相对路径
 *  @params       请求参数
 *  @finish      完成回调
 */
- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;
/**
 *  上传图片 (单张或一组)
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <IceUploadParam *> *)uploadParams
                    success:(void (^)())success
                    failure:(void (^)(NSError *error))failure;
/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)())progress
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure;


@end

@interface IceUploadParam : NSObject
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;
@end
