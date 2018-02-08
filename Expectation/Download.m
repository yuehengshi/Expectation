//
//  Download.m
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import "Download.h"
#import "MainTabBarController.h"
#import "AFNetworking.h"
#import "sqlite3.h"
#import "NetTools.h"
#import "itemModel.h"
#import "dayModel.h"
#import "SZKImagePickerVC.h"
#import "MBProgressHUD.h"
@interface Download ()

@end

@implementation Download

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.keyboardType = UIKeyboardTypeASCIICapable;
    self.password.keyboardType = UIKeyboardTypeASCIICapable;

}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_username resignFirstResponder];
     [_password resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 回收键盘
    [textField resignFirstResponder];
    return YES;
    
}
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
-(NSMutableArray *)get_picPath{
    NSMutableArray *temp_imagePath=[[NSMutableArray alloc]init];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *allPath =[manager subpathsAtPath:paths[0]];
    for (NSString *subPath in allPath) {
        if ([subPath containsString:@"data.db"]||[subPath containsString:@"DS_Store"])
        {
        }
        else{
            [temp_imagePath addObject:subPath];
        }
    }
    
    
    return temp_imagePath;
}
-(NSMutableArray *)get_picFullpath:(NSArray *)imagePath
{
       NSMutableArray *temp_imagePath=[[NSMutableArray alloc]init];    
    for(int i=0;i<imagePath.count;i++){
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        [temp_imagePath addObject:[paths[0] stringByAppendingPathComponent:imagePath[i]]];
        
    }
    
    
    return temp_imagePath;
}
-(void)delete_sandBox{
    NSFileManager *fm=[NSFileManager defaultManager];
    NSArray *temp=[self get_picFullpath:[self get_picPath]];
    for(int i=0;i<temp.count;i++){
    [fm removeItemAtPath:temp[i] error:nil];
    }
}
-(void)download_pic:(NSDictionary*)parameter{
 
    [NetTools Network_Download_pic:parameter  view:self.view success:^(id json) {
        NSLog(@"请求下载json：%@",json);
        NSArray *dict = json;
           [self delete_sandBox];
        UIImage *temp=[[UIImage alloc]init];
        NSString *name;
        NSRange range;
        for(int i=0;i<dict.count;i++){
            name=dict[i];
        NSURL *url=[NSURL URLWithString:dict[i]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        temp=[UIImage imageWithData:data];
            range = NSMakeRange(name.length-19,14);
            [SZKImagePickerVC saveImageToSandbox:temp andImageNage:[dict[i] substringWithRange:range] andResultBlock:^(BOOL success) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"保存成功");
            }];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"下载图片失败！！！%@",error);

    }];

}
- (IBAction)download:(id)sender {
    [self NetStatus];
    if([_num isEqual:@"0"])
    {
        [self NoNetAlert];
    }
    else
    {
    if(_username.text.length!=0&&_password.text.length!=0)
    {
        NSDictionary * parmes = @{@"username":_username.text,@"password":_password.text};
        NSDictionary * parmes1 = @{@"username":_username.text};
        [NetTools check_user:parmes view:self.view  success:^(id json) {
            NSLog(@"%@",json);
            if([[json objectForKey:@"result"] isEqual:@"1"])
            {
                if([[json objectForKey:@"data"] isEqual:@"1"])
                {
                    [NetTools Network_Download_item:parmes1  view:self.view success:^(id json) {
                        NSLog(@"请求下载json：%@",json);
                        NSDictionary *dict = json;
                        
                        _arraM=[[NSMutableArray alloc]init];
                        for(NSDictionary *ndict in dict)
                        {
                            _model=[itemModel AccountModelWithDict:ndict];
                            NSLog(@"%@",_model);
                            [_arraM addObject:_model];
                        }
                        _array=_arraM ;
                        [self savein_database];
                       
                        
                    } failure:^(NSError *error) {
                        NSLog(@"下载备份失败！！！%@",error);
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载备份失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:okAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }];
                    
                    [NetTools Network_Download_day:parmes1  view:self.view success:^(id json) {
                        NSLog(@"请求下载json：%@",json);
                        NSDictionary *dict = json;                        
                        _arraM1=[[NSMutableArray alloc]init];
                        for(NSDictionary *ndict in dict)
                        {
                            _model1=[dayModel AccountModelWithDict:ndict];
                            NSLog(@"%@",_model1);
                            [_arraM1 addObject:_model1];
                        }
                        _array1=_arraM1 ;
                        [self savein_database];
                        
                    } failure:^(NSError *error) {
                        NSLog(@"下载备份失败！！！%@",error);
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载备份失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:okAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }];
                    //下载图片
                    [self download_pic:parmes1];
                    
                    [NetTools Network_Download_world:parmes1  view:self.view success:^(id json) {
                        NSLog(@"请求下载json：%@",json);
                        NSDictionary *dict = json;
                        _arraM2=[[NSMutableArray alloc]init];
                        for(NSDictionary *ndict in dict)
                        {
                            _model2=[worldModel AccountModelWithDict:ndict];
                            NSLog(@"%@",_model2);
                            [_arraM2 addObject:_model2];
                        }
                        _array2=_arraM2 ;
                        [self savein_database];
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回主界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
                            
                            [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                            
                            [self presentViewController:vc animated:YES completion:nil];
                        }];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            _username.text=@"";
                            _password.text=@"";
                        }];
                        [alertController addAction:okAction];
                        [alertController addAction:cancelAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    } failure:^(NSError *error) {
                        NSLog(@"下载备份失败！！！%@",error);
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载备份失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:okAction];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }];


                }

                else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前账号无备份" message:@"请备份后再尝试" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回主界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
                        
                        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                        
                        [self presentViewController:vc animated:YES completion:nil];
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新尝试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        _username.text=@"";
                        _password.text=@"";
                    }];
                    [alertController addAction:okAction];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
                
                
            }
            else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"账号或密码错误" message:@"或者没有此账号" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    _username.text=@"";
                    _password.text=@"";
                }];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"登陆失败！！！%@",error);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
       
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"账号或密码为空" message:@"我们需要您的账号来备份" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    }
}
-(void)savein_database{
    sqlite3 *database;
    
    char *errorMsg = NULL;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false");
        sqlite3_close(database);
    //    NSAssert(0, @"Failed to open database");
    }
    NSString *deleteRow = @"DELETE FROM item where id>1";
    sqlite3_exec(database, [deleteRow UTF8String], NULL, NULL, nil);
    NSString *deleteRow1 = @"DELETE FROM day where id>1";
    sqlite3_exec(database, [deleteRow1 UTF8String], NULL, NULL, nil);
    NSString *deleteRow2 = @"DELETE FROM world";
    sqlite3_exec(database, [deleteRow2 UTF8String], NULL, NULL, nil);
    for(int i=0;i<_array.count;i++)
    {
        sqlite3_stmt *stmt;
        _model=_array[i];
    NSString *insert = [NSString stringWithFormat:@"insert into item (title, category,time,iftop,ifpass,backImage,ifremind,music) values ('%@', '%@','%@', '%@','%@', '%@','%@','%@')",_model.title,_model.category,_model.time,_model.iftop ,_model.ifpass,_model.backimage,_model.ifremind,_model.music];
    NSLog(@"%@",insert);
    
    
    sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
        NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_finalize(stmt);
    }
    for(int i=0;i<_array1.count;i++)
    {
        sqlite3_stmt *stmt;
        _model1=_array1[i];
        NSString *insert = [NSString stringWithFormat:@"insert into day (title, category,time,iftop,ifpass,backImage,ifremind,music,interval) values ('%@', '%@','%@', '%@','%@', '%@','%@','%@','%@')",_model1.title,_model1.category,_model1.time,_model1.iftop ,_model1.ifpass,_model1.backimage,_model1.ifremind,_model1.music,_model1.interval];
        NSLog(@"%@",_model1.interval);
        NSLog(@"%@",insert);
        
        
        sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
        
        if (sqlite3_step(stmt) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_finalize(stmt);
    }
    for(int i=0;i<_array2.count;i++)
    {
        sqlite3_stmt *stmt;
        _model2=_array2[i];
        NSString *insert = [NSString stringWithFormat:@"insert into world (timezone,country) values ('%@','%@')",_model2.timezone,_model2.country];
        NSLog(@"%@",_model2.timezone);
        NSLog(@"%@",insert);
        
        
        sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
        
        if (sqlite3_step(stmt) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_finalize(stmt);
    }


    
    
    sqlite3_close(database);

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
