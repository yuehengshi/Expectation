//
//  theme.m
//  Expectation
//
//  Created by Syh on 16/8/28.
//  Copyright © 2016年 5. All rights reserved.
//

#import "theme.h"
#import "addNewAffairTableViewController.h"
#import "addNew.h"
@interface theme ()

@end

@implementation theme

- (void)viewDidLoad {
    [super viewDidLoad];
    _titileText.text=_title_data;
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_titileText resignFirstResponder];

}
-(void)backTo{
    if([_current_page isEqual:@"1"])
    {
        [self performSegueWithIdentifier:@"theme_back" sender:nil];
    }
    else if([_current_page isEqual:@"2"]){
    [self performSegueWithIdentifier:@"theme_back2" sender:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"theme_back"])
{
    addNewAffairTableViewController *vc=segue.destinationViewController;
   
    vc.title_data=_titileText.text;
    vc.category=_category;
    vc.image=_image;
    vc.hour_data=_hour_data;
    vc.min_data=_min_data;
    vc.sec_data=_sec_data;
    vc.iftop_data=_iftop_data;
    vc.id=_id;
    vc.modelIndex=_modelIndex;
       vc.if_UISwitch_enable=_if_UISwitch_enable;
     vc.ifedit=_ifedit;
    vc.ifremind_data=_ifremind_data;
    vc.music=_music;
    vc.current_page=_current_page;
    vc.temp_imagePath=_temp_imagePath;
    vc.imgNum=_imgNum;
}
    if ([segue.identifier isEqualToString:@"theme_back2"])
    {
        addNew *vc=segue.destinationViewController;
        vc.category=_category;
        vc.image=_image;
        vc.title_data=_titileText.text;
        vc.hour_data=_hour_data;
        vc.min_data=_min_data;
        vc.sec_data=_sec_data;
        vc.iftop_data=_iftop_data;
        vc.id=_id;
        vc.modelIndex=_modelIndex;
        vc.if_UISwitch_enable=_if_UISwitch_enable;
        vc.ifedit=_ifedit;
        vc.ifremind_data=_ifremind_data;
        vc.music=_music;
        vc.current_page=_current_page;
        vc.time_data=_time_data;
        vc.time_string=_time_string;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
