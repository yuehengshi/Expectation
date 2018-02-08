//
//  NetTools.h
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"
#import "MBProgressHUD.h"
@interface NetTools : NSObject
@property (strong, nonatomic)NSString *num;
+(void)Network_upload_item:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)check_user:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)Network_Download_item:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)Network_Download_day:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)Network_Download_pic:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)Network_Download_world:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)advice:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)register:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

- (int)NetStatus;
@end
