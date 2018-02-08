//
//  AppDelegate.h
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(void)registerNotification_item: (int)Time  ID:(NSString*)ID  param:(NSDictionary*)param;
+(void)registerNotification_day: (NSString*)Time  ID:(NSString*)ID  param:(NSDictionary*)param;
+ (NSString*)deviceVersion;
@end

