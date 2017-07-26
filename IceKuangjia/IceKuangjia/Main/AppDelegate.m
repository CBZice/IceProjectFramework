//
//  AppDelegate.m
//  IceKuangjia
//
//  Created by sanmi on 16/7/8.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "IceTabBarController.h"

@interface AppDelegate ()<AVSpeechSynthesizerDelegate>{
    AVSpeechSynthesizer*av;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    IceTabBarController *tabBar = [[IceTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - 语音播报
- (void)start:(NSString *)str {
    if([av isPaused]) {
        //如果暂停则恢复，会从暂停的地方继续
        [av continueSpeaking];
    }else{
        //初始化对象
        av= [[AVSpeechSynthesizer alloc]init];
        av.delegate=self;//挂上代理
        
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:str];//需要转换的文字
        utterance.rate = 0.5;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
        utterance.voice= voice;
        [av speakUtterance:utterance];//开始
    }
}

// 获取更新信息
-(void)hsUpdateApp
{
    
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^{
        NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1190835723"]] returningResponse:nil error:nil];
        if (response == nil) {
            return ;
        }
        NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = appInfoDic[@"results"];
        NSDictionary *dic = array[0];
        NSString *appStoreVersion = dic[@"version"];
        
        NSString * currStr = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString * appStr = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        if([currStr intValue] < [appStr intValue])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"暂不更新"otherButtonTitles:@"前往更新",nil];
            [alert show];
        }else{
            
        }
    });
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
