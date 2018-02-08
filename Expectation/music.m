//
//  music.m
//  Expectation
//
//  Created by Syh on 16/9/16.
//  Copyright © 2016年 5. All rights reserved.
//

#import "music.h"
#import "addNewAffairTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "addNew.h"
@interface music ()

@end

@implementation music
@synthesize selectedIndexPath;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.title=@"提示音乐";
   // self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationItem.leftBarButtonItem=barBtn1;
}
-(void)backTo{
    if([_current_page isEqual:@"1"])
    {
        [self performSegueWithIdentifier:@"music_back" sender:nil];
    }
    else if([_current_page isEqual:@"2"]){
    [self performSegueWithIdentifier:@"music_back2" sender:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
        _music=@"无";
    if(indexPath.row==1)
    {   _music=@"等灯灯灯";
        [self music:_music];
    }
    if(indexPath.row==2)
    {   _music=@"坦克大战";
        [self music:_music];
    }
    if(indexPath.row==3)
    {   _music=@"重机枪";
        [self music:_music];
    }
    if(indexPath.row==4)
    {   _music=@"好听";
        [self music:_music];
    }
    if(indexPath.row==5)
    {   _music=@"火箭";
        [self music:_music];
    }
    if(indexPath.row==6)
    {   _music=@"空灵";
        [self music:_music];
    }
    if(indexPath.row==7)
    {   _music=@"恐怖";
        [self music:_music];
    }
    if(indexPath.row==8)
    {   _music=@"马林巴琴混音";
        [self music:_music];
    }
    if(indexPath.row==9)
    {   _music=@"闹钟";
        [self music:_music];
    }
    if(indexPath.row==10)
    {   _music=@"敲键盘";
        [self music:_music];
    }
    if(indexPath.row==11)
    {   _music=@"WIN10";
        [self music:_music];
    }
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"music_back"])
    {
    addNewAffairTableViewController *vc=segue.destinationViewController;
    vc.category=_category;
    vc.title_data=_title_data;
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
    if ([segue.identifier isEqualToString:@"music_back2"])
    {
        addNew *vc=segue.destinationViewController;
        vc.category=_category;
        vc.title_data=_title_data;
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
-(void) music:(NSString*)music
{
            NSString *name=[NSString stringWithFormat:@"%@.mp3",music];
            NSURL *url=[[NSBundle mainBundle]URLForResource:name withExtension:Nil];
            AVAudioPlayer *audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
            audioPlayer.numberOfLoops = -1;
            [audioPlayer prepareToPlay];
            [audioPlayer play];
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"试听中" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"结束试听" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [audioPlayer stop];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
 
    
}


@end
