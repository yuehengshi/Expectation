//
//  single_5s.m
//  Expectation
//
//  Created by Syh on 16/9/26.
//  Copyright © 2016年 5. All rights reserved.
//

#import "single_5s.h"
#import "dayModel.h"
#import "addNewAffairTableViewController.h"
#import "MainTabBarController.h"
#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "addNew.h"
@interface single_5s ()
@property (strong, nonatomic)dayModel *bookModel;
@property (strong, nonatomic)NSArray *detailArray;
@property (strong, nonatomic) NSArray *detailArray1;
@end

@implementation single_5s

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem=barBtn2;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    [self initData];
    [self initWidget];
}
-(void)backTo
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
-(void)edit{
    dayModel * model;
    if([_iftop isEqual:@"0"])
    {
        model = _detailArray[[_modelIndex intValue]];
    }
    else{
        model = _detailArray1[[_modelIndex intValue]];
        
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    addNew *vc = (addNew*)[storyboard instantiateViewControllerWithIdentifier:@"addNew2"];
    vc.ifedit=@"1";
    vc.title_data=model.title;
    vc.category=model.category;
    vc.iftop_data=model.iftop;
    if([model.iftop isEqual:@"1"])
    {   vc.if_UISwitch_enable=@"0";}
    vc.image=model.backimage;
    vc.id=model.id;
    vc.modelIndex=_modelIndex;
    vc.music=model.music;
    vc.ifremind_data=model.ifremind;
    vc.current_page=_current_page;
    vc.time_data=model.time;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    vc.time_string=[dateFormatter stringFromDate:currentTime];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    //[_timer setFireDate:[NSDate distantFuture]];
    //    [timer1 invalidate];
    // [timer1 setFireDate:[NSDate distantFuture]];
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
-(void)initWidget
{
    dayModel * model;
    if([_iftop isEqual:@"0"])
    {
        model = _detailArray[[_modelIndex intValue]];
    }
    else{
        model = _detailArray1[[_modelIndex intValue]];
        
    }
    if([model.ifpass isEqual:@"0"])
        _status.text=@"还剩";
    else
        _status.text=@"已超过";
    _time.text = model.interval;
    
    
    if([model.category  isEqual:@"生日"])
        _pic.image=[UIImage imageNamed:@"shengri"];
    if([model.category  isEqual:@"节日"])
        _pic.image=[UIImage imageNamed:@"jieri"];
    if([model.category  isEqual:@"纪念日"])
        _pic.image=[UIImage imageNamed:@"jinianri"];
    if([model.category  isEqual:@"学校"])
        _pic.image=[UIImage imageNamed:@"xuexiao"];
    if([model.category  isEqual:@"考试"])
        _pic.image=[UIImage imageNamed:@"kaoshi"];
    if([model.category  isEqual:@"生活"])
        _pic.image=[UIImage imageNamed:@"shenghuo"];
    _theme.text=model.title;
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:model.backimage] ];
    
}


- (void)initData
{
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false");
        sqlite3_close(database);
        //   NSAssert(0, @"Failed to open database");
    }
    else{
        NSString *query1 = @"SELECT * FROM day where iftop=0";
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
                NSString *interval = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
                NSDictionary *tempDict = @{@"id":id, @"title":title, @"category":category, @"time":time,@"iftop":iftop, @"ifpass":ifpass,@"backimage":backimage,@"ifremind":ifremind,@"music":music,@"interval":interval};
                
                dayModel *model = [dayModel AccountModelWithDict:tempDict];
                
                [modelArr addObject:model];
                
            }
            
            _detailArray = modelArr;
            sqlite3_finalize(statement);
        }
        
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM day where iftop='%d'",1];
        if (sqlite3_prepare_v2(database, [query UTF8String],-1, &statement, nil) == SQLITE_OK)
        {
            NSMutableArray *modelArr = [NSMutableArray array];
            while (sqlite3_step(statement) == SQLITE_ROW) {
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
        sqlite3_close(database);
    }
}
-(void)remind:(NSString*)ifremind title:(NSString*)title music:(NSString*)music
{
    if([ifremind isEqual:@"1"])
    {
        if([music isEqual:@"无"])
        {
            NSString *alert=[NSString stringWithFormat:@"事件 %@ 已经倒计时完毕",title];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alert message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSString *name=[NSString stringWithFormat:@"%@.mp3",music];
            NSURL *url=[[NSBundle mainBundle]URLForResource:name withExtension:Nil];
            AVAudioPlayer *audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
            audioPlayer.numberOfLoops = -1;
            [audioPlayer prepareToPlay];
            [audioPlayer play];
            NSString *alert=[NSString stringWithFormat:@"事件 %@ 已经倒计时完毕",title];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alert message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [audioPlayer stop];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
