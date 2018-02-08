//
//  NetTools.m
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import "NetTools.h"
#import "AFNetWorking.h"
#import "MBProgressHUD.h"
@implementation NetTools

+(void)Network_upload_item:(NSDictionary*)dict view:(UIView*)view  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{ [MBProgressHUD showHUDAddedTo:view animated:YES];
    
//    
//    NSURLSession *session=[NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1/Exceptation/insert_user.php?username=%@&password=%@",[dict objectForKey:@"username"],[dict objectForKey:@"password"]]];
//  
//    NSURLSessionTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",result);
//        
//
//    }];
//    [task resume];
        NSString *urlstr2 = @"http://www.netsama.cn/syh/expectation/insert_user.php";
        NSDictionary *dic2 = @{@"username":[dict objectForKey:@"username"],@"password":[dict objectForKey:@"password"]};
        NSLog(@"%@",dic2);
       AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        manager1.requestSerializer = [AFJSONRequestSerializer serializer];
        manager1.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        [manager1 GET:urlstr2 parameters:dic2 progress:^(NSProgress * _Nonnull uploadProgress) {}
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if(success){
                       [MBProgressHUD hideHUDForView:view animated:YES];
          //  NSLog(@"success -- %@",responseObject);
                  // success=[responseObject objectForKey:@"result"];
                   success(responseObject);
                   }
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(failure){
                [MBProgressHUD hideHUDForView:view animated:YES];
            NSLog(@"failure -- error = %@",error);
                failure(error);

                
            }
        }];
  
 
    
}
+(void)Network_Download_pic:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //        NSDictionary *para=@{@"username":_username.text,@"password":_password.text};
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/download_pic.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    
    //   manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求成功：%@",responseObject);
             success(responseObject);
             
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求失败：%@",error.localizedDescription );
             failure(error);
             
             
         }];
}
+(void)Network_Download_item:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{

    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //        NSDictionary *para=@{@"username":_username.text,@"password":_password.text};
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/send_item.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
   
 //   manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求成功：%@",responseObject);
              success(responseObject);
                         
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求失败：%@",error.localizedDescription );
             failure(error);

             
         }];
}
+(void)Network_Download_day:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //        NSDictionary *para=@{@"username":_username.text,@"password":_password.text};
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/send_day.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    
    //   manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求成功：%@",responseObject);
             success(responseObject);
             
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求失败：%@",error.localizedDescription );
             failure(error);
             
             
         }];
}
+(void)Network_Download_world:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/send_world.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    
    //   manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求成功：%@",responseObject);
             success(responseObject);
             
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"下载备份请求失败：%@",error.localizedDescription );
             failure(error);
             
             
         }];
}

+(void)check_user:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", [dict objectForKey:@"password"], @"password",nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/check_user.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"验证用户请求成功：%@",responseObject);
             success(responseObject);
            
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"验证用户请求失败：%@",error.localizedDescription );
             failure(error);

         }];
}
+(void)advice:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"content"], @"content",nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/advice.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"提交建议请求成功：%@",responseObject);
             success(responseObject);
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"提交建议请求失败：%@",error.localizedDescription );
             failure(error);
         }];
}
+(void)register:(NSDictionary*)dict view:(UIView*)view success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"username"], @"username", [dict objectForKey:@"password"], @"password",nil];
    NSString *path = @"http://www.netsama.cn/syh/expectation/insert_user.php";
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [manager GET:path parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        // 请求进度
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"注册请求成功：%@",responseObject);
             success(responseObject);
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [MBProgressHUD hideHUDForView:view animated:YES];
             NSLog(@"注册请求失败：%@",error.localizedDescription );
             failure(error);
         }];
}
- (int)NetStatus
{

    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
[manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {  NSLog(@"未知");
                _num= @"0";
                break;}
            case AFNetworkReachabilityStatusNotReachable:
            {    NSLog(@"没有网络");
                _num= @"0";
                break;}
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {   NSLog(@"3G|4G");
                _num= @"1";
                break;}
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {    NSLog(@"WiFi");
                _num= @"1";
                break;}
            default:
            { _num= @"0";
                break;}
        }
    }];
    
    
    return [_num intValue];
}

@end
