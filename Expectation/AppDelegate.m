//
//  AppDelegate.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainTabBarController.h"
#import "GuideVC.h"
#import "FirstViewController.h"
#import "NavigationController.h"
#import <UserNotifications/UserNotifications.h>
#import "sys/utsname.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6or6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6plusor6splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
@end

@implementation AppDelegate
UIBackgroundTaskIdentifier backgroundTask;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
    // 1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

   MainTabBarController *dragVC = [[MainTabBarController alloc]init];
    GuideVC *vc=[[GuideVC alloc]init];

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
         self.window.rootViewController =vc;
    }else{
          self.window.rootViewController =dragVC;
    }
    
        // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}
+(void)registerNotification_item: (int)Time  ID:(NSString*)ID  param:(NSDictionary*)param{
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:[param objectForKey:@"category"] arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"%@的%@已经到了！！！",[param objectForKey:@"title"],[param objectForKey:@"category"]]
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:Time repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:ID
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
           }];
}
+(void)registerNotification_day: (NSString*)Time  ID:(NSString*)ID  param:(NSDictionary*)param{
 
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
 
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:[param objectForKey:@"category"] arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"%@的%@已经到了！！！",[param objectForKey:@"title"],[param objectForKey:@"category"]]
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[Time intValue]];

    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];NSLog(@"%@",dateComponents);
//    NSDateComponents *dateComponent1=[[NSDateComponents alloc]init];
//    [dateComponents setYear:2016];
//    [dateComponents setMonth:9];
//    [dateComponents setDay:24];
//    [dateComponents setHour:6];
//    [dateComponents setMinute:0];
//    [dateComponents setSecond:0];
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger
                                                  triggerWithDateMatchingComponents:dateComponents repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:ID
                                                                          content:content trigger:trigger];
    

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];

 
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
 //   NSLog(@"%@",deviceString);
//    if ([deviceString isEqualToString:@"iPhone5,1"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone5,2"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone5,3"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone5,4"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone6,1"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone6,2"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone7,1"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPhone7,2"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPhone8,1"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPhone8,2"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPhone8,4"])
//        return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone9,1"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPhone9,2"])
//        return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"i386"])
//        return @"iPhone Simulator";
//    if ([deviceString isEqualToString:@"x86_64"])
//        return @"iPhone Simulator";
    
    if (isiPhone5or5sor5c) {
        return @"iPhone 5S" ;
    } else if (isiPhone6or6s) {
        return @"iPhone 6S Plus";
    } else if (isiPhone6plusor6splus) {
        return @"iPhone 6S Plus";;
    }
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    [self backTask];
}
- (void)backTask{
    
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] < 61.0) {
        
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        
    }
    
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
