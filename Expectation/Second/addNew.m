//
//  addNew.m
//  Expectation
//
//  Created by Syh on 16/9/19.
//  Copyright © 2016年 5. All rights reserved.
//

#import "addNew.h"
#import "category.h"
#import "theme.h"
#import "backImage.h"
#import "music.h"
#import "FirstViewController.h"
#import "singleDisplay.h"
#import "ZHPickView.h"
#import "single.h"
#import "AppDelegate.h"
#import "single_5s.h"
#import <UserNotifications/UserNotifications.h>
#import "UIImagePickerController+Judge.h"
#import "SZKImagePickerVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface addNew ()
{
    int iftop_value;
    
}
@property(nonatomic,strong)ZHPickView *pickview;
@property (strong,nonatomic)  UIImagePickerController * pickerImage;
@end

@implementation addNew
@synthesize selectedIndexPath;

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imgNum=0;
    _temp_imagePath=[[NSMutableArray alloc]init];
      self.pickerImage =[[UIImagePickerController alloc] init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self ifTransparentNav:NO];
    //  _iftop_data=@"1";
    // [_iftop setOn:YES];
    [self initWidget];
    [self initTop];
    iftop_value=1;
    [_title_input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

}
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.title_input)  //判断是否时我们想要限定的那个输入框
    {
        _top_title.text=_title_input.text;
        
    }
  }

-(void)initTop{
    if(_time_data.length==0)
    {
        _top_day.text=@"0";
    }
    else{
        NSDate * today = [NSDate date];
        NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[_time_data intValue]];
        NSString *interval = [NSString stringWithFormat:@"%ld",labs((long)[self getDaysFrom:today To:currentTime])];

        _top_day.text=interval;
    }
    if(_categoryLabel.text.length==0)
    {
        _top_pic.image=[UIImage imageNamed:@"jinianri"];
    }else{
        if([_category isEqual:@"纪念日"])
            _top_pic.image=[UIImage imageNamed:@"jinianri"];
        if([_category isEqual:@"节日"])
            _top_pic.image=[UIImage imageNamed:@"jieri"];
        if([_category isEqual:@"考试"])
            _top_pic.image=[UIImage imageNamed:@"kaoshi"];
        if([_category isEqual:@"生活"])
            _top_pic.image=[UIImage imageNamed:@"shenghuo"];
        if([_category isEqual:@"学校"])
            _top_pic.image=[UIImage imageNamed:@"xuexiao"];
        if([_category isEqual:@"生日"])
            _top_pic.image=[UIImage imageNamed:@"shengri"];
    }
    if(_image.length==0)
        _top_back.image=[UIImage imageNamed:@"back1"];
    else
    {
        if ([_image containsString:@"back"]) {
            _top_back.image=[UIImage imageNamed:_image];
        }
        else{
            //_top_back.image=[UIImage imageWithContentsOfFile:_image];
            _top_back.image=[UIImage imageWithContentsOfFile:[self addPath:_image]];
        }
    }
    if(_title_input.text.length==0)
        _top_title.text=@"主题";
    else
        _top_title.text=_title_data;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 回收键盘
    [textField resignFirstResponder];
    return YES;
    
}
-(NSString*)addPath:(NSString*)path{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *temp=[paths[0] stringByAppendingPathComponent:path];
    return  temp;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

-(void)hideKeyboard:(UITapGestureRecognizer *)gestureRecognizer
{
    [_pickview remove];
    [self.view endEditing:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        [_pickview show];
    }
    if(indexPath.section==3&&indexPath.row==1)
    {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            
        }];
        
//        UIAlertAction *online = [UIAlertAction actionWithTitle:@"打开在线壁纸中心" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            }
////            [self presentViewController:imagePicker animated:YEScompletion:nil];
//            
//        }];
        UIAlertAction *offline = [UIAlertAction actionWithTitle:@"打开本地壁纸库" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            

            [self performSegueWithIdentifier:@"to_backImage2" sender:nil];
            
        }];

        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.pickerImage.delegate = self;
            self.pickerImage.allowsEditing = NO;
            if ([_pickerImage isAvailablePhotoLibrary])
            {
                [self presentViewController:_pickerImage animated:YES completion:nil];
            }else
            {
            }
        }];
        [alertVc addAction:cancle];
//        [alertVc addAction:online];
        [alertVc addAction:offline];
        [alertVc addAction:picture];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    ////获取数据类型
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    ///如果是图片类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //如果是图库选择图片，否则是拍照
        
        [self chosePhoto:picker WithInfo:info];
        
        
        
    }
}
//用户取消选取时调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


///选择照片
-(void)chosePhoto:(UIImagePickerController*)picker WithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    ///选择相片后移除相册
    [picker dismissViewControllerAnimated:YES completion:^{
        ///显示图片
        [self getImage:picker Info:info];
        
    }];
}
/////显示获取选取后的图片
-(void)getImage:(UIImagePickerController*)picker Info:(NSDictionary<NSString *,id> *)info{
    UIImage * image;
    //如果允许被编辑，获取编辑后的图片，否则获取原始图片
    if (picker.allowsEditing) {
        ///编辑后的图片
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        //原始图片
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //显示图片
    _pic.image = image;
    _top_back.image=image;
    NSString *temp_time;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *temp=[NSDate date];
    [_temp_imagePath addObject:[dateFormatter stringFromDate:temp]];
    
    
    [SZKImagePickerVC saveImageToSandbox:image andImageNage:_temp_imagePath[_imgNum] andResultBlock:^(BOOL success) {
        NSLog(@"保存成功");
    }];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if(_imgNum!=0){
        NSFileManager *fm=[NSFileManager defaultManager];
        NSString *filepath=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum-1]];
        [fm removeItemAtPath:filepath error:nil];
    }
    //_image=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum]];
    _image=_temp_imagePath[_imgNum];
    _imgNum++;
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    _timeLabel.text=resultString;
    _time_string=resultString;
    

    
}
-(void)date:(ZHPickView *)pickView resultString_date:(NSDate*)resultString_date{
    _resultString_date=resultString_date;
    NSDate * today = [NSDate date];

    // 时间转换成时间戳
    _time_data = [NSString stringWithFormat:@"%ld",(long)[_resultString_date timeIntervalSince1970]];
    NSLog(@"timeSp : %@", _time_data);
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[_time_data intValue]];
    NSLog(@"currentTime : %@", currentTime);
    NSLog(@"%@",_resultString_date);
    NSString *interval = [NSString stringWithFormat:@"%ld",labs((long)[self getDaysFrom:today To:currentTime])];
    _top_day.text=interval;

    
    if((long)[self getDaysFrom:today To:currentTime]>0)
    {
        _top_status.text=@"还剩";
    }
    else{
        _top_status.text=@"已超过";
    }


}
-(void)initWidget{
    if([_music isEqual:@"无"])
    {
        _musicLabel.text=@"无";
    }
    else{
        _musicLabel.text=_music;
    }
    _categoryLabel.text=_category;
    _title_input.text=_title_data;
    if ([_image containsString:@"back"]) {
        _pic.image=[UIImage imageNamed:_image];
    }
    else{
        //_pic.image=[UIImage imageWithContentsOfFile:_image];
        _pic.image=[UIImage imageWithContentsOfFile:[self addPath:_image]];
    }
    if(_time_data==nil)
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"目标日期:YYYY年MM月dd日"];
        NSDate *temp=[NSDate date];
        _timeLabel.text =[dateFormatter stringFromDate:temp];
        _time_data=[NSString stringWithFormat:@"%ld",(long)[temp timeIntervalSince1970]];


    }
    else {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"目标日期:YYYY年MM月dd日"];
    NSDate *temp = [NSDate dateWithTimeIntervalSince1970:[_time_data intValue]];
    _timeLabel.text =[dateFormatter stringFromDate:temp];
    }
    
    
    if(_categoryLabel.text.length==0)
        _categoryLabel.text=@"纪念日";
    if(_image.length==0)
        _image=@"back4";
    if([_iftop_data isEqual:@"1"])
        [_iftop setOn:YES];
    else
        [_iftop setOn:NO];
    
    if([_ifremind_data isEqual:@"1"])
        [_ifremind setOn:YES];
    else
        [_ifremind setOn:NO];
    if([_ifedit isEqual:@"0"])
    {
        self.navigationItem.title=@"新建";
    }
    else{
        self.navigationItem.title=@"编辑";
    }
    UIColor * color1 = [UIColor blackColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
    
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    if([_if_UISwitch_enable isEqual:@"0"])
    {
        [self.iftop addTarget:self action:@selector(switchIsClicked)
             forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.iftop addTarget:self action:@selector(switchIsChanged)
             forControlEvents:UIControlEventValueChanged];
    }
    [self.ifremind addTarget:self action:@selector(switchIsChanged)
            forControlEvents:UIControlEventValueChanged];
    
}
-(void)backTo{
    [_pickview remove];
    
    UIColor * color1 = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
    [self ifTransparentNav:YES];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    if([_ifedit isEqual:@"0"])
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
    else
    {
        //  [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] animated:YES];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {
            single_5s *vc = (single_5s*)[storyboard instantiateViewControllerWithIdentifier:@"single_5s"];
            vc.iftop=_iftop_data;
            vc.current_page=_current_page;
            if([_iftop_data isEqual:@"0"])
                vc.modelIndex=_modelIndex;
            else
                vc.modelIndex=@"0";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            single *vc = (single*)[storyboard instantiateViewControllerWithIdentifier:@"single"];
            vc.iftop=_iftop_data;
            vc.current_page=_current_page;
            if([_iftop_data isEqual:@"0"])
                vc.modelIndex=_modelIndex;
            else
                vc.modelIndex=@"0";
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }
    
    
}
-(void)submit{
    [_pickview remove];
    
    if(_title_input.text.length ==0||_timeLabel.text.length==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"主题和日期不能为空" message:@"请添加主题和时间" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        UIColor * color1 = [UIColor whiteColor];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
        [self ifTransparentNav:YES];
        self.navigationController.navigationBar.titleTextAttributes=dict;
        
        if([_ifedit isEqual:@"0"])
        {
            [self addInfo];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        }
        else
        {
            [self editInfo];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
            {
                single_5s *vc = (single_5s*)[storyboard instantiateViewControllerWithIdentifier:@"single_5s"];
                vc.iftop=_iftop_data;
                vc.current_page=_current_page;
                if([_iftop_data isEqual:@"0"])
                    vc.modelIndex=_modelIndex;
                else
                    vc.modelIndex=@"0";
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                single *vc = (single*)[storyboard instantiateViewControllerWithIdentifier:@"single"];
                vc.iftop=_iftop_data;
                vc.current_page=_current_page;
                if([_iftop_data isEqual:@"0"])
                    vc.modelIndex=_modelIndex;
                else
                    vc.modelIndex=@"0";
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            
        }
    }
}
-(void)editInfo
{
   // _time_data=[NSString stringWithFormat:@"%d",[_hour.text intValue]*3600+[_min.text intValue]*60+[_sec.text intValue]];
    NSLog(@"%@",_time_data);
    sqlite3 *database;
    sqlite3_stmt *stmt;
    char *errorMsg = NULL;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false");
        sqlite3_close(database);
        //   NSAssert(0, @"Failed to open database");
    }
    if([_iftop_data isEqual:@"1"])
    {NSString *update = @"UPDATE day SET iftop = 0 WHERE iftop = 1";
        sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"更新成功");
        }
    }
    int ifpass;
    NSDate * today = [NSDate date];
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[_time_data intValue]];
    NSString *interval = [NSString stringWithFormat:@"%ld",labs((long)[self getDaysFrom:today To:currentTime])];
    if((long)[self getDaysFrom:today To:currentTime]>0)
    {
        ifpass=0;
    }
    else{
        ifpass=1;
    }
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSLog(@"%@",notifications);
    }];
    [center removePendingNotificationRequestsWithIdentifiers: @[_time_data]];
    
    [center removeDeliveredNotificationsWithIdentifiers:@[_time_data] ];
    if([_ifremind_data intValue])
    {
        NSDictionary * param = @{@"title":_title_input.text,@"category":_categoryLabel.text};
        [AppDelegate registerNotification_day:_time_data  ID:_title_input.text  param:param];
    }

    NSString *update1 = [NSString stringWithFormat:@"update day set title='%@', category='%@',time='%@',iftop='%d',ifpass='%d',backImage='%@',ifremind='%d',music='%@',interval='%@' where id='%d'",_title_input.text,_categoryLabel.text,_time_data,[_iftop_data intValue] ,ifpass,_image,[_ifremind_data intValue],_music,interval,[_id intValue]];
    NSLog(@"%@",update1);
    
    
    sqlite3_prepare_v2(database, [update1 UTF8String], -1, &stmt, NULL);
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
        NSAssert(0, @"Error updating table: %s", errorMsg);
    sqlite3_finalize(stmt);
    
    sqlite3_close(database);
    
}
-(void)switchIsClicked
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不能设置为非置顶" message:@"将其他事项置顶后，此事项会自动调整" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    [_iftop setOn:YES];
    
    
}
-(void)switchIsChanged
{
    if ([self.iftop isOn]){
        
        _iftop_data=@"1";
        NSLog(@"The switch is on.");
    } else {
        
        _iftop_data=@"0";
        NSLog(@"The switch is off.");
    }
    if ([self.ifremind isOn]){
        
        _ifremind_data=@"1";
        NSLog(@"The switch is on.");
    } else {
        
        _ifremind_data=@"0";
        NSLog(@"The switch is off.");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"category_to2"])
    {
        category *vc=segue.destinationViewController;
        vc.category=_category;
        vc.title_data_other=_title_input.text;
        vc.image=_image;
      //  vc.hour_data=_hour.text;
       // vc.min_data=_min.text;
      //  vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"theme_to2"])
    {
        theme *vc=segue.destinationViewController;
        vc.title_data=_titleLabel.text;
        vc.category=_category;
        vc.image=_image;
      //  vc.hour_data=_hour.text;
       // vc.min_data=_min.text;
      //  vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"to_backImage2"])
    {
        backImage *vc=segue.destinationViewController;
        vc.title_data=_title_input.text;
        vc.category=_category;
        vc.image=_image;
     //   vc.hour_data=_hour.text;
      //  vc.min_data=_min.text;
     //   vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"music_to2"])
    {
        music *vc=segue.destinationViewController;
        vc.title_data=_title_input.text;
        vc.category=_category;
        vc.image=_image;
     //   vc.hour_data=_hour.text;
     //   vc.min_data=_min.text;
     //   vc.sec_data=_sec.text;
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
    //    FirstViewController *vc=segue.destinationViewController;
    //    [vc.tableView reloadData];
}
-(void)addInfo
{
   // _time_data=[NSString stringWithFormat:@"%d",[_hour.text intValue]*3600+[_min.text intValue]*60+[_sec.text intValue]];
    NSLog(@"%@",_time_data);
    sqlite3 *database;
    sqlite3_stmt *stmt;
    char *errorMsg = NULL;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false");
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    if([_iftop_data isEqual:@"1"])
    {NSString *update = @"UPDATE day SET iftop = 0 WHERE iftop = 1";
        sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"更新成功");
        }
    }
    NSString *music_data;
    if(_musicLabel.text.length==0)
    {
        music_data=@"无";
    }
    else{
        music_data=_music;
    }

    if([_ifremind_data intValue])
    {
        NSDictionary * param = @{@"title":_title_input.text,@"category":_categoryLabel.text};
        [AppDelegate registerNotification_day: _time_data  ID:_title_input.text  param:param];
    }

    
    int ifpass;
    NSDate * today = [NSDate date];
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[_time_data intValue]];
    NSString *interval = [NSString stringWithFormat:@"%ld",labs((long)[self getDaysFrom:today To:currentTime])];
    if((long)[self getDaysFrom:today To:currentTime]>0)
    {
        ifpass=0;
    }
    else{
        ifpass=1;
    }
    NSString *insert = [NSString stringWithFormat:@"insert into day (title, category,time,iftop,ifpass,backImage,ifremind,music,interval) values ('%@', '%@','%@', '%d','%d', '%@','%d','%@','%@')",_title_input.text,_categoryLabel.text,_time_data,[_iftop_data intValue] ,ifpass,_image,[_ifremind_data intValue],music_data,interval];
    NSLog(@"%@",insert);
    
    
    sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
        NSAssert(0, @"Error inserting table: %s", errorMsg);
    
    sqlite3_finalize(stmt);
    
    sqlite3_close(database);
}

-(void)ifTransparentNav:(BOOL)value{
    if(value){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage=[UIImage new];
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white"] forBarMetrics:0];
    }
}
-(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}
@end


