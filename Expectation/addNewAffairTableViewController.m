//
//  addNewAffairTableViewController.m
//  Expectation
//
//  Created by Syh on 16/8/28.
//  Copyright © 2016年 5. All rights reserved.
//

#import "addNewAffairTableViewController.h"
#import "category.h"
#import "theme.h"
#import "backImage.h"
#import "music.h"
#import "FirstViewController.h"
#import "singleDisplay.h"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "singleDisplay_5s.h"
#import "UIImagePickerController+Judge.h"
#import "SZKImagePickerVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#define NUMBERS @"0123456789"
@interface addNewAffairTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int iftop_value;
 
}
@property (strong,nonatomic)  UIImagePickerController * pickerImage;
@end

@implementation addNewAffairTableViewController
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
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
     self.pickerImage =[[UIImagePickerController alloc] init];
    [self ifTransparentNav:NO];
   //  _iftop_data=@"1";
   // [_iftop setOn:YES];
    [self initWidget];
    [self initTop];
    iftop_value=1;
    _current_page=@"1";
    _hour.delegate=self;
    _min.delegate=self;
    _sec.delegate=self;
//    _title_input.delegate=self;
     [_title_input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [_hour addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [_min addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     [_sec addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 回收键盘
    [textField resignFirstResponder];
    return YES;
    
}
-(void)hideKeyboard:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
-(void)initTop{

    if((_hour.text.length!=0)||(_min.text.length!=0)||(_sec.text.length!=0))
    {
        _top_time.text=[self SecToTime:[_hour_data intValue]*3600+[_min_data intValue]*60+[_sec_data intValue]];
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
-(NSString*)addPath:(NSString*)path{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *temp=[paths[0] stringByAppendingPathComponent:path];
    return  temp;
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
    
    _hour.text=_hour_data;
    _min.text=_min_data;
    _sec.text=_sec_data;
    if(_categoryLabel.text.length==0)
        _categoryLabel.text=@"纪念日";
    if(_image.length==0)
        _image=@"back1";
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
            singleDisplay_5s *vc = (singleDisplay_5s*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay_5s"];
            vc.iftop=_iftop_data;
            vc.current_page=_current_page;
            if([_iftop_data isEqual:@"0"])
                vc.modelIndex=_modelIndex;
            else
                vc.modelIndex=@"0";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            singleDisplay *vc = (singleDisplay*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay"];
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

    if(_title_input.text.length ==0||_categoryLabel.text.length ==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"主题和分类不能为空" message:@"请添加主题和分类" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else{
        if(([_hour.text intValue]*3600+[_min.text intValue]*60+[_sec.text intValue])<6&&[_ifremind_data isEqual:@"1"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"时间小于6秒时不能设置提醒" message:@"请修改信息" preferredStyle:UIAlertControllerStyleAlert];
            
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
                singleDisplay_5s *vc = (singleDisplay_5s*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay_5s"];
                vc.iftop=_iftop_data;
                vc.current_page=_current_page;
                if([_iftop_data isEqual:@"0"])
                    vc.modelIndex=_modelIndex;
                else
                    vc.modelIndex=@"0";
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                singleDisplay *vc = (singleDisplay*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay"];
                vc.iftop=_iftop_data;
                vc.current_page=_current_page;
                if([_iftop_data isEqual:@"0"])
                    vc.modelIndex=_modelIndex;
                else
                    vc.modelIndex=@"0";
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        //    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] animated:YES];

        }
        }
    }
}
-(void)editInfo
{
    _time_data=[NSString stringWithFormat:@"%d",[_hour.text intValue]*3600+[_min.text intValue]*60+[_sec.text intValue]];
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
    {NSString *update = @"UPDATE item SET iftop = 0 WHERE iftop = 1";
         sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"更新成功");
        }
    }
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSLog(@"%@",notifications);
    }];

    [center removePendingNotificationRequestsWithIdentifiers: @[_title_input.text]];
    
      [center removeDeliveredNotificationsWithIdentifiers:@[_title_input.text] ];
    if([_ifremind_data intValue])
    {
        NSDictionary * param = @{@"title":_title_input.text,@"category":_categoryLabel.text};
        [AppDelegate registerNotification_item:[_time_data intValue] ID:_title_input.text  param:param];
    
    }
//    if ([_image containsString:@"back"]) {
////        if(_imgNum!=0){
////            NSFileManager *fm=[NSFileManager defaultManager];
////            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////            NSString *filePath=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum-1]];
////            [fm removeItemAtPath:filePath error:nil];
////        }
////        else{
////            NSFileManager *fm=[NSFileManager defaultManager];
////            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////            NSString *filePath=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum]];
////            [fm removeItemAtPath:filePath error:nil];
////
////        }
//    }
//    else{
//        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        _image=[paths[0] stringByAppendingPathComponent:_image];
//    }

    NSString *update1 = [NSString stringWithFormat:@"update  item set title='%@', category='%@',time='%@',iftop='%d',ifpass='%d',backImage='%@',ifremind='%d',music='%@' where id='%d'",_title_input.text,_categoryLabel.text,_time_data,[_iftop_data intValue] ,0,_image,[_ifremind_data intValue],_music,[_id intValue]];
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
-(NSString*)SecToTime:(int)Seconds{
    NSString *time;
    NSString *temp=@"";
    int h=0,m=0,s=0,miao;
    miao=Seconds;
    h=miao/3600;
    m=miao/60-h*60;
    s=miao-h*3600-m*60;
    time=[temp stringByAppendingFormat:@"%d:%.2d:%.2d",abs(h),abs(m),abs(s) ];
    
    return time;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
//        //[self presentViewController:imagePicker animated:YEScompletion:nil];
//            
//        }];
        UIAlertAction *offline = [UIAlertAction actionWithTitle:@"打开本地壁纸库" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self performSegueWithIdentifier:@"to_backImage1" sender:nil];
            
        }];
        
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ///协议
            self.pickerImage.delegate = self;
            //图片允许编辑
            self.pickerImage.allowsEditing = NO;
            
            /*
             *检测相册是否可用，即是否存在数据源
             */
            if ([_pickerImage isAvailablePhotoLibrary])
            {
                ///回调
                [self presentViewController:_pickerImage animated:YES completion:nil];
            }else
            {
                
      //          [AlertViewController ViewController:self altetViewtitle:@"友情提示" Message:@"相册不可用" action:@"确定"];
            }

        }];
        [alertVc addAction:cancle];
    //    [alertVc addAction:online];
        [alertVc addAction:offline];
        [alertVc addAction:picture];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    /* 用户选取的信息都在info里
     *info里的键值如下：
     * NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（如下：）
     * NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     * NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     * NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     * NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     * NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     * NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     */
    /*指定用户选择的媒体类型
     *UIImagePickerControllerMediaType 包含着KUTTypeImage 和KUTTypeMovie
     说明：使用指定媒体类型 需包含  <MobileCoreServices/MobileCoreServices.h>库
     
     KUTTypeImage 包含：
     const CFStringRef  kUTTypeImage ;抽象的图片类型
     const CFStringRef  kUTTypeJPEG ;
     const CFStringRef  kUTTypeJPEG2000 ;
     const CFStringRef  kUTTypeTIFF ;
     const CFStringRef  kUTTypePICT ;
     const CFStringRef  kUTTypeGIF ;
     const CFStringRef  kUTTypePNG ;
     const CFStringRef  kUTTypeQuickTimeImage ;
     const CFStringRef  kUTTypeAppleICNS
     const CFStringRef kUTTypeBMP;
     const CFStringRef  kUTTypeICO;
     
     KUTTypeMovie 包含：
     const CFStringRef  kUTTypeAudiovisualContent ;抽象的声音视频
     const CFStringRef  kUTTypeMovie ;抽象的媒体格式（声音和视频）
     const CFStringRef  kUTTypeVideo ;只有视频没有声音
     const CFStringRef  kUTTypeAudio ;只有声音没有视频
     const CFStringRef  kUTTypeQuickTimeMovie ;
     const CFStringRef  kUTTypeMPEG ;
     const CFStringRef  kUTTypeMPEG4 ;
     const CFStringRef  kUTTypeMP3 ;
     const CFStringRef  kUTTypeMPEG4Audio ;
     const CFStringRef  kUTTypeAppleProtectedMPEG4Audio;
     */
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

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.title_input)  //判断是否时我们想要限定的那个输入框
    {
        _top_title.text=_title_input.text;
       
    }
    if ((textField == self.hour)||(textField == self.min)||(textField == self.sec)) {
       _top_time.text=[self SecToTime:[self.hour.text intValue]*3600+[self.min.text intValue]*60+[self.sec.text intValue]];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    

        NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
        }
    else
    {
    if (self.hour == textField)  //判断是否时我们想要限定的那个输入框
    {//_top_time.text=[self SecToTime:[self.hour.text intValue]*3600+[self.min.text intValue]*60+[self.sec.text intValue]];
        [self.hour.text stringByReplacingCharactersInRange:range withString:string];
        

        if (range.location >= 2)
        {
            return NO;
        }
                return YES;
    }
    else if (self.min == textField)
    {//_top_time.text=[self SecToTime:[self.hour.text intValue]*3600+[self.min.text intValue]*60+[self.sec.text intValue]];
        [self.min.text stringByReplacingCharactersInRange:range withString:string];
        

        if (range.location >= 2)
        {
            return NO;
        }
      
        return YES;
    }
    else if (self.sec == textField) 
    {//_top_time.text=[self SecToTime:[self.hour.text intValue]*3600+[self.min.text intValue]*60+[self.sec.text intValue]];
         [self.sec.text stringByReplacingCharactersInRange:range withString:string];
        

        if (range.location >= 2)
        {
            return NO;
        }
                return YES;
    }
    }
    
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"category_to"])
    {
   category *vc=segue.destinationViewController;
    vc.category=_category;
        vc.title_data_other=_title_input.text;
        vc.image=_image;
        vc.hour_data=_hour.text;
        vc.min_data=_min.text;
        vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"theme_to"])
    {
        theme *vc=segue.destinationViewController;
        vc.title_data=_titleLabel.text;
        vc.category=_category;
         vc.image=_image;
        vc.hour_data=_hour.text;
        vc.min_data=_min.text;
        vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"to_backImage1"])
    {
        backImage *vc=segue.destinationViewController;
        vc.title_data=_title_input.text;
        vc.category=_category;
        vc.image=_image;
        vc.hour_data=_hour.text;
        vc.min_data=_min.text;
        vc.sec_data=_sec.text;
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
    if ([segue.identifier isEqualToString:@"music_to"])
    {
        music *vc=segue.destinationViewController;
        vc.title_data=_title_input.text;
        vc.category=_category;
        vc.image=_image;
        vc.hour_data=_hour.text;
        vc.min_data=_min.text;
        vc.sec_data=_sec.text;
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
//    FirstViewController *vc=segue.destinationViewController;
//    [vc.tableView reloadData];
}
-(void)addInfo
{
    _time_data=[NSString stringWithFormat:@"%d",[_hour.text intValue]*3600+[_min.text intValue]*60+[_sec.text intValue]];
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
    {NSString *update = @"UPDATE item SET iftop = 0 WHERE iftop = 1";
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
        [AppDelegate registerNotification_item:[_time_data intValue] ID:_title_input.text  param:param];
    }
//    if ([_image containsString:@"back"]) {
////        if(_imgNum!=0){
////            NSFileManager *fm=[NSFileManager defaultManager];
////            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////            NSString *filePath=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum-1]];
////            [fm removeItemAtPath:filePath error:nil];
////        }
////        else{
////            NSFileManager *fm=[NSFileManager defaultManager];
////            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////            NSString *filePath=[paths[0] stringByAppendingPathComponent:_temp_imagePath[_imgNum]];
////            [fm removeItemAtPath:filePath error:nil];
////            
////        }
//
//    }
//    else{
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    _image=[paths[0] stringByAppendingPathComponent:_image];
//    }
    NSString *insert = [NSString stringWithFormat:@"insert into item (title, category,time,iftop,ifpass,backImage,ifremind,music) values ('%@', '%@','%@', '%d','%d', '%@','%d','%@')",_title_input.text,_categoryLabel.text,_time_data,[_iftop_data intValue] ,0,_image,[_ifremind_data intValue],music_data];
    NSLog(@"%@",insert);
   

    sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
   
    if (sqlite3_step(stmt) != SQLITE_DONE)
        NSAssert(0, @"Error inserting table: %s", errorMsg);
    sqlite3_finalize(stmt);
    
    sqlite3_close(database);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_hour resignFirstResponder];
     [_min resignFirstResponder];
     [_sec resignFirstResponder];
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
@end
