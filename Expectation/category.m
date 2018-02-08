//
//  category.m
//  Expectation
//
//  Created by Syh on 16/8/28.
//  Copyright © 2016年 5. All rights reserved.
//

#import "category.h"
#import "addNewAffairTableViewController.h"
#import "theme.h"
#import "addNew.h"
@interface category ()

@end

@implementation category
@synthesize selectedIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableFooterView = [[UIView alloc] init];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
 

   self.navigationItem.title=@"分类";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
-(void)backTo{
    if([_current_page isEqual:@"1"])
    {
 [self performSegueWithIdentifier:@"category_back" sender:nil];
    }
    else if([_current_page isEqual:@"2"]){
         [self performSegueWithIdentifier:@"category_back2" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
        if (self->selectedIndexPath) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self->selectedIndexPath];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self->selectedIndexPath = indexPath;
    if(indexPath.row==0)
        _category=@"纪念日";
    if(indexPath.row==1)
        _category=@"节日";
    if(indexPath.row==2)
        _category=@"考试";
    if(indexPath.row==3)
        _category=@"生活";
    if(indexPath.row==4)
        _category=@"学校";
    if(indexPath.row==5)
        _category=@"生日";
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"category_back"])
    {
    addNewAffairTableViewController *vc=segue.destinationViewController;
    vc.category=_category;
    vc.title_data=_title_data_other;
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
    if ([segue.identifier isEqualToString:@"category_back2"])
    {
        addNew *vc=segue.destinationViewController;
        
        vc.category=_category;
        vc.title_data=_title_data_other;
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
        vc.time_data=_time_data;
        vc.time_string=_time_string;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
