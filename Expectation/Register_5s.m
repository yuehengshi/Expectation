//
//  Register_5s.m
//  Expectation
//
//  Created by Syh on 16/9/25.
//  Copyright © 2016年 5. All rights reserved.
//

#import "Register_5s.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import "MBProgressHUD.h"
#import "Login_5s.h"
#import "NetTools.h"
#import "MainTabBarController.h"
#import "MBProgressHUD.h"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@interface Register_5s ()




@end

@implementation Register_5s

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.keyboardType = UIKeyboardTypeASCIICapable;
    self.password.keyboardType = UIKeyboardTypeASCIICapable;
    _username.delegate=self;
    _password.delegate=self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    else
    {
        if (self.username == textField)  //判断是否时我们想要限定的那个输入框
        {
            [self.username.text stringByReplacingCharactersInRange:range withString:string];
            if (range.location >= 9)
            {
                return NO;
            }
            return YES;
        }
        else if (self.password == textField)
        {
            [self.password.text stringByReplacingCharactersInRange:range withString:string];
            if (range.location >= 9)
            {
                return NO;
            }
            return YES;
        }
    }
    
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}
- (IBAction)register:(id)sender {
    [self NetStatus];
    if([_num isEqual:@"0"])
    {
        [self NoNetAlert];
    }
    else
    {
        
        if(_username.text.length!=0&&_password.text.length!=0)
        {
            NSDictionary * parmes = @{@"username":_username.text};
            NSDictionary * parmes1 = @{@"username":_username.text,@"password":_password.text};
            [NetTools check_user:parmes view:self.view success:^(id json) {
                NSLog(@"%@",json);
                if([[json objectForKey:@"exist"] isEqual:@"0"])
                {
                    [NetTools register:parmes1 view:self.view success:^(id json) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回主界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
                            
                            [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                            
                            [self presentViewController:vc animated:YES completion:nil];
                            
                        }];
                        [alertController addAction:okAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    } failure:^(NSError *error) {
                        NSLog(@"注册失败！！！%@",error);
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:okAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }];
                    //    NSURLSession *session=[NSURLSession sharedSession];
                    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.91.111/Exceptation/insert_user.php?username=%@&password=%@",_username.text,_password.text]];
                    //    NSLog(@"%@",url);
                    //    NSLog(@"%@  %@",_username.text,_password.text);
                    //       NSURLSessionTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    //        NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    //      NSLog(@"%@",result);
                    //   }];
                    //   [task resume];
                    
                }
                else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"此账号已有人使用" message:@"请更换您要注册的账号" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction =  [UIAlertAction actionWithTitle:@"重新注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        _username.text=@"";
                        _password.text=@"";
                    }];
                    
                    [alertController addAction:okAction];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
            }
                         failure:^(NSError *error) {
                             NSLog(@"注册失败！！！%@",error);
                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                             
                             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                             [alertController addAction:okAction];
                             
                             [self presentViewController:alertController animated:YES completion:nil];
                             
                         }];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"账号或密码为空" message:@"请您填写完整的信息" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        //    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/Exceptation/insert_user.php"];
        //
        //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //
        //    request.HTTPMethod = @"POST";
        //    request.HTTPBody = [[NSString stringWithFormat:@"username=%@&password=%@",_username.text,_password.text] dataUsingEncoding:NSUTF8StringEncoding];
        //
        //    NSURLSession *session = [NSURLSession sharedSession];
        //
        //    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        //        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", result);
        //
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"result:%@",dic[@"result"]);
        //
        //    }];
        
        //    [task resume];
        
        //
        //NSURL *url=[NSURL URLWithString:@"http://172.19.79.122/Exceptation/insert_user.php"];
        //    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url ];
        //    [request setHTTPMethod:@"POST"];
        //    NSDictionary *jsonDic=@{@"username":_username.text,
        //                            @"password":_password.text};
        //    NSData *data;
        // //   NSError *error;
        //
        //    data=[NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
        //     //   [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
        //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //    [request setHTTPBody:data];
        //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //        NSLog(@"%@",data);
        //    }];
        
        //    NSMutableDictionary *resultsDictionary;// 返回的 JSON 数据
        //    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:_username.text, @"username",_password.text,@"password",nil];
        //    if ([NSJSONSerialization isValidJSONObject:userDictionary])
        //    {
        //
        //        NSError *error;
        //
        //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        //        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        //        NSURL *url = [NSURL URLWithString:@"http://172.19.79.122/Exceptation/insert_user.php"];
        //
        //        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
        //        [request addRequestHeader:@"Accept" value:@"application/json"];
        //
        //        [request setRequestMethod:@"POST"];
        //        [request setPostBody:tempJsonData];
        //        [request startSynchronous];
        //        NSError *error1 = [request error];
        //        if (!error1)
        //        {
        //            NSString *response = [request responseString];
        //            NSLog(@"Test：%@",response);
        //            NSData* jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
        //
        //        }
        //    }
        
        //
        //    NSDictionary * parmes = @{@"username":_username.text,@"password":_password.text};
        //
        //    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
        //    [manger POST:@"http://172.19.79.122/Exceptation/insert_user.php" parameters:parmes progress:^(NSProgress * _Nonnull uploadProgress) {
        //
        //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //                       //调用撤销窗口
        //
        //        });
        //
        //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        //    }];
        
        //    NSString *urlstr2 = @"http://127.0.0.1/Exceptation/insert_user.php";
        //    NSDictionary *dic2 = @{@"username":_username.text,@"password":_password.text};
        //    NSLog(@"%@",dic2);
        //   AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
        //    manager1.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager1.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        //    [manager1 POST:urlstr2 parameters:dic2 progress:^(NSProgress * _Nonnull uploadProgress) {}
        //           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"success -- %@",responseObject);
        //
        //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"failure -- error = %@",error);
        //    }];
        
        //NSDictionary * parmes = @{@"username":_username.text,@"password":_password.text};
        //     _arraM = [[NSMutableArray alloc] init];
        //    [NetTools Network_Logon:parmes success:^(id json) {
        //        NSLog(@"%@",json);
        //        if([[json objectForKey:@"result"] isEqual:@"success"])
        //            [self performSegueWithIdentifier:@"register_back" sender:nil];
        //        
        //    } failure:^(NSError *error) {
        //            NSLog(@"登陆失败！！！%@",error);
        //    }];
    }
}
-(void)NoNetAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接" message:@"请在设置中打开您的网络" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)NetStatus
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
    
    
}

@end

