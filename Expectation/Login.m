//
//  Login.m
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import "Login.h"
#import "AFNetworking.h"
#import "itemModel.h"
#import "sqlite3.h"
#import "MainTabBarController.h"
#import "NetTools.h"
#import "MBProgressHUD.h"
#import "ShenAFN.h"
@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataBase];
    self.username.keyboardType = UIKeyboardTypeASCIICapable;
    self.password.keyboardType = UIKeyboardTypeASCIICapable;
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入账号" attributes:
//                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                        NSFontAttributeName:_username.font
//                                        }];
//    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
//                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                        NSFontAttributeName:_password.font
//                                        }];
//
//    _username.attributedPlaceholder = attrString;
//    _password.attributedPlaceholder = attrString1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_username resignFirstResponder];
    [_password resignFirstResponder];
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
-(NSMutableArray *)get_pic:(NSArray *)imagePath
{
  //  NSData *imageData =nil;
 //   NSString *mimeType =nil;
    UIImage *image=[[UIImage alloc]init];
    NSMutableArray *temp_imageData=[[NSMutableArray alloc]init];
    
    for(int i=0;i<imagePath.count;i++){
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath=[paths[0] stringByAppendingPathComponent:imagePath[i]];
    image=[UIImage imageWithContentsOfFile:filepath];
    
    [temp_imageData addObject:image];
        
    }
    

    return temp_imageData;
}
-(void)upload_pic:(NSString *)username{


    NSString *url = @"http://www.netsama.cn/syh/expectation/upload_pic.php";


//    [[ShenAFN sharedInstance] uploadMutableimgWithurl:url imagearray:[self imageBase64WithDataURL:[self get_picPath]] name:[self get_picPath] success:^(id jsondata) {
//        NSString *result = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", result);
//    } fail:^{
//        NSLog(@"请求失败");
//    }];
    for(int i=0;i<[self get_picPath].count;i++){
        [[ShenAFN sharedInstance] uploadimgWithurl:url image:[self get_pic:[self get_picPath]][i] fileName:[self get_picPath][i] username:username success:^(id jsondata)
        {
                    NSString *result = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", result);
                } fail:^{
                    NSLog(@"请求失败");
                }];
        
        
    }
}

- (IBAction)backup:(id)sender {
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
       
       [NetTools check_user:parmes view:self.view success:^(id json) {
           NSLog(@"%@",json);
           if([[json objectForKey:@"result"] isEqual:@"1"])
           {
               NSDate *today = [NSDate date];   
               NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
               [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
               NSString * date=[dateFormatter stringFromDate:today];
               NSLog(@"%@",date);
              
               for(int i=0;i<_detailArray.count;i++)
               {
                   _itemModel=_detailArray[i];
                   NSString *title=[_itemModel.title                                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *category=[_itemModel.category stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *time=[date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *music=[_itemModel.music stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSURLSession *session=[NSURLSession sharedSession];
                   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.netsama.cn/syh/expectation/insert_backups.php?username=%@&password=%@&title=%@&category=%@&time=%@&iftop=%@&ifpass=%@&backimage=%@&ifremind=%@&music=%@&date=%@",_username.text,_password.text,title,category,_itemModel.time,_itemModel.iftop,_itemModel.ifpass,_itemModel.backimage,_itemModel.ifremind,music,time]];
                   
                   NSLog(@"%@",url);
                   NSURLSessionTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                       NSLog(@"%@",result);
                       
                   }];
                   [task resume];
                   
               }
               for(int i=0;i<_detailArray1.count;i++)
               {
                   _dayModel=_detailArray1[i];
                   NSString *title=[_dayModel.title                                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *category=[_dayModel.category stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *time=[date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *music=[_dayModel.music stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *interval=[_dayModel.interval stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSURLSession *session=[NSURLSession sharedSession];
                   NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.netsama.cn/syh/expectation/insert_day.php?username=%@&password=%@&title=%@&category=%@&time=%@&iftop=%@&ifpass=%@&backimage=%@&ifremind=%@&music=%@&date=%@&intervaldata=%@",_username.text,_password.text,title,category,_dayModel.time,_dayModel.iftop,_dayModel.ifpass,_dayModel.backimage,_dayModel.ifremind,music,time,interval]];
                   
                   NSLog(@"%@",url1);
                   NSURLSessionTask *task1=[session dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                       NSLog(@"%@",result);
                       
                   }];
                   [task1 resume];
                   
               }
               //上传完图片本地路径后，再上传图片，并在php中执行插入真实路径的语句
               [self upload_pic:_username.text];
               for(int i=0;i<_detailArray2.count;i++)
               {
                   _worldModel=_detailArray2[i];
                   NSString *timezone=[_worldModel.timezone                                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *time=[date stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSString *country=[_worldModel.country stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   NSURLSession *session=[NSURLSession sharedSession];
                   NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.netsama.cn/syh/expectation/insert_world.php?username=%@&password=%@&timezone=%@&date=%@&country=%@",_username.text,_password.text,timezone,time,country]];
                   
                   NSLog(@"%@",url2);
                   NSURLSessionTask *task1=[session dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                       NSLog(@"%@",result);
                       
                   }];
                   [task1 resume];
                   
               }

               
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"备份成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
               
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回主界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
                   
                   [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                   
                   [self presentViewController:vc animated:YES completion:nil];
               }];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续备份" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   _username.text=@"";
                   _password.text=@"";
               }];
               [alertController addAction:okAction];
               [alertController addAction:cancelAction];
               [self presentViewController:alertController animated:YES completion:nil];


           }
           else {
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
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"备份失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
           
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

- (void)initDataBase
{
       sqlite3 *database;
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false1");
        sqlite3_close(database);
        //        NSAssert(0, @"Failed to open database");
    }
    else{
        NSString *query1 = @"SELECT * FROM item where id>1";
        if (sqlite3_prepare_v2(database, [query1 UTF8String],-1, &statement, nil) == SQLITE_OK)
        {
            NSMutableArray *modelArr = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {//对表中的数据进行遍历
                NSString *id = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *title = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *category = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *time = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *iftop = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *ifpass = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *backimage = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *ifremind = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                NSString *music = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                NSDictionary *tempDict = @{@"id":id, @"title":title, @"category":category, @"time":time,@"iftop":iftop, @"ifpass":ifpass,@"backimage":backimage,@"ifremind":ifremind,@"music":music};

                itemModel *model = [itemModel AccountModelWithDict:tempDict];
                [modelArr addObject:model];
                
               
            }
            _detailArray = modelArr;
            sqlite3_finalize(statement);
        }
            NSString *query2 = @"SELECT * FROM day where id>1";
            if (sqlite3_prepare_v2(database, [query2 UTF8String],-1, &statement, nil) == SQLITE_OK)
            {
                NSMutableArray *modelArr = [NSMutableArray array];
                while (sqlite3_step(statement) == SQLITE_ROW) {//对表中的数据进行遍历
                    NSString *id = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *title = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *category = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *time = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *iftop = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *ifpass = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *backimage = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *ifremind = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    NSString *music = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                    NSString *interval = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
                    NSDictionary *tempDict = @{@"id":id, @"title":title, @"category":category, @"time":time,@"iftop":iftop, @"ifpass":ifpass,@"backimage":backimage,@"ifremind":ifremind,@"music":music,@"interval":interval};
                    
                    dayModel *model = [dayModel AccountModelWithDict:tempDict];
                    [modelArr addObject:model];
                }
                _detailArray1 = modelArr;
            sqlite3_finalize(statement);
        }
        NSString *query3 = @"SELECT * FROM world ";
        if (sqlite3_prepare_v2(database, [query3 UTF8String],-1, &statement, nil) == SQLITE_OK)
        {
            NSMutableArray *modelArr = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {//对表中的数据进行遍历
                NSString *id = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *timezone = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                 NSString *country = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSDictionary *tempDict = @{@"id":id, @"timezone":timezone,@"country":country};
                
                worldModel *model = [worldModel AccountModelWithDict:tempDict];
                [modelArr addObject:model];
            }
            _detailArray2 = modelArr;
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(database);
    }
    
}
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    
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
