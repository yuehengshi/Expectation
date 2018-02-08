//
//  Advice.m
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import "Advice.h"
#import "NetTools.h"
#import "MainTabBarController.h"
@interface Advice ()

@end

@implementation Advice

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text.layer.borderWidth = 2;
    self.text.layer.cornerRadius = 10.0f;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_text resignFirstResponder];

}


- (IBAction)submit:(id)sender {
    [self NetStatus];
    if([_num isEqual:@"0"])
    {
        [self NoNetAlert];
    }
    else
    {

    if(_text.text.length!=0)
    {
        NSDictionary * parmes = @{@"content":_text.text};
        [NetTools advice:parmes  view:self.view success:^(id json) {
            NSLog(@"%@",json);
            if([[json objectForKey:@"result"] isEqual:@"success"])
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"我们会认真考虑您的建议！" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回主界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
                    
                    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                    
                    [self presentViewController:vc animated:YES completion:nil];
                    
                }];
                UIAlertAction *cancelAction =  [UIAlertAction actionWithTitle:@"再提一条" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    _text.text=@"";
                }];
                
                [alertController addAction:okAction];
                [alertController addAction:cancelAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交失败" message:@"请再次尝试" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction =  [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
                 failure:^(NSError *error) {
                     NSLog(@"提交失败！！！%@",error);
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交失败" message:@"无法连接服务器" preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                     [alertController addAction:okAction];
                     
                     [self presentViewController:alertController animated:YES completion:nil];
                 }];
        
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请留下您宝贵的意见" message:@"谢谢！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
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
