//
//  singleDisplay.m
//  Expectation
//
//  Created by Syh on 16/8/30.
//  Copyright © 2016年 5. All rights reserved.
//

#import "singleDisplay.h"
#import "itemModel.h"
#import "addNewAffairTableViewController.h"
#import "MainTabBarController.h"
#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface singleDisplay ()
{
    NSTimer *timer1;
}
@property (strong, nonatomic)itemModel *itemModel;
@property (strong, nonatomic)NSArray *detailArray;
@property (strong, nonatomic) NSArray *detailArray1;
@end

@implementation singleDisplay
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
   // UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];

    self.navigationItem.leftBarButtonItem=barBtn1;
   // UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"编辑"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
     self.navigationItem.rightBarButtonItem=barBtn2;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [timer1 invalidate];

     timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
  //  [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
     [self initData];
    [self initWidget];
}
-(void)backTo
{
    [timer1 setFireDate:[NSDate distantFuture]];
    [timer1 invalidate];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
-(void)edit{
    itemModel * model;
    if([_iftop isEqual:@"0"])
    {
        model = _detailArray[[_modelIndex intValue]];
    }
    else{
        model = _detailArray1[[_modelIndex intValue]];
        
    }

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    addNewAffairTableViewController *vc = (addNewAffairTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"addNew1"];
    vc.ifedit=@"1";
    vc.title_data=model.title;
    vc.category=model.category;
    vc.hour_data=[self SecToHour:model.time];
     vc.min_data=[self SecToMin:model.time];
     vc.sec_data=[self SecToSec:model.time];
    vc.iftop_data=model.iftop;
    if([model.iftop isEqual:@"1"])
    {   vc.if_UISwitch_enable=@"0";}
    vc.image=model.backimage;
    vc.id=model.id;
    vc.modelIndex=_modelIndex;
    vc.music=model.music;
    vc.ifremind_data=model.ifremind;
    vc.current_page=_current_page;
    [timer1 setFireDate:[NSDate distantFuture]];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [timer1 setFireDate:[NSDate distantPast]];
  self.tabBarController.tabBar.hidden=YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    //[_timer setFireDate:[NSDate distantFuture]];
//    [timer1 invalidate];
   // [timer1 setFireDate:[NSDate distantFuture]];
}
-(void)initWidget
{
    itemModel * model;
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
    _time.text=[self SecToTime:model.time];
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
    if ([model.backimage containsString:@"back"]) {
        self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:model.backimage] ];
    }
    else{
       
       
        
       // self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageWithContentsOfFile://[self addPath:model.backimage]]];
        _backImg.image=[UIImage imageWithContentsOfFile:[self addPath:model.backimage]];
       // _backImg.contentMode = UIViewContentModeScaleAspectFit;

        }

    
}
-(NSString*)addPath:(NSString*)path{
  NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *temp=[paths[0] stringByAppendingPathComponent:path];
  return  temp;
}
-(void)timerFireMethod
{
     NSLog(@"timer1111");
    [self decreaseTime];
    [self initData];
    [self initWidget];

}
-(void)decreaseTime
{
    if (_detailArray.count > 0)
    {
        for( int i=1;i<_detailArray.count;i++)
        {
            itemModel * model = _detailArray[i];
            
            if([model.ifpass isEqual:@"0"])
            {
                
                if(![model.time isEqual:@"0"])
                {
                    [self updateTime:[model.id intValue]n:i iftop:NO];
                }
                else
                {
                    [self updateIfpass:[model.id intValue]];
                    [self remind:model.ifremind title:model.title music:model.music];
                }
            }
            else
            {
                [self updateTime:[model.id intValue]n:i iftop:NO];
                
            }
            
        }
        
    }
    if (_detailArray1.count > 0)
    {
        for(int i=0;i<(int)_detailArray1.count;i++)
        {
            itemModel * model = _detailArray1[i];
            if([model.ifpass isEqual:@"0"])
            {
                if(![model.time isEqual:@"0"])
                {
                    [self updateTime:[model.id intValue]n:i iftop:YES];
                }
                else
                {
                    [self updateIfpass:[model.id intValue]];
                    [self remind:model.ifremind title:model.title music:model.music];
                }
            }
            else
            {
                [self updateTime:[model.id intValue]n:i iftop:YES];
                
            }
        }
        
    }
    
}
-(void)updateTime:(int)ID n:(int)n iftop:(BOOL)iftop
{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
  //      NSAssert(0, @"Failed to open database");
    }
    else
    {
    itemModel * model;
    if(iftop)
    { model = _detailArray1[n];}
    else{
        model = _detailArray[n];
    }
    

    sqlite3_stmt *stmt;
    NSString *update = [NSString stringWithFormat:@"update item set time='%@' where id='%d'",[NSString stringWithFormat:@"%d",[model.time intValue]-1],ID];
    
    int result = sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
    }
    if (sqlite3_step(stmt) == SQLITE_DONE)
     //   NSAssert(0, @"Error updating table: %s", errorMsg);
    { sqlite3_finalize(stmt);
        sqlite3_close(database);}
    }
    
}
-(void)updateIfpass:(int)ID
{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
     //   NSAssert(0, @"Failed to open database");
    }
    else{

    sqlite3_stmt *stmt;
    NSString *update = [NSString stringWithFormat:@"update item set ifpass=1 where id='%d'",ID];
    
    int result = sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
    }
    if (sqlite3_step(stmt) == SQLITE_DONE)
      //  NSAssert(0, @"Error updating table: %s", errorMsg);
    { sqlite3_finalize(stmt);
        sqlite3_close(database);}
    }
    
}
-(NSString*)SecToTime:(NSString*)Seconds{
    NSString *time;
    NSString *temp=@"";
    int h=0,m=0,s=0,miao;
    miao=[Seconds intValue];
    h=miao/3600;
    m=miao/60-h*60;
    s=miao-h*3600-m*60;
    time=[temp stringByAppendingFormat:@"%d:%.2d:%.2d",abs(h),abs(m),abs(s) ];
    return time;
}
-(NSString*)SecToHour:(NSString*)Seconds{
 
 
    int h=0,miao;
    miao=[Seconds intValue];
    h=miao/3600;
    NSLog(@"h is %d",h);
    return [NSString stringWithFormat:@"%d",abs(h)];
}
-(NSString*)SecToMin:(NSString*)Seconds{
    int h=0,m=0,miao;
    miao=[Seconds intValue];
    h=miao/3600;
    m=miao/60-h*60;
     NSLog(@"m is %d",m);
    return [NSString stringWithFormat:@"%d",abs(m)];
}
-(NSString*)SecToSec:(NSString*)Seconds{
    int h=0,m=0,s=0,miao;
    miao=[Seconds intValue];
    h=miao/3600;
    m=miao/60-h*60;
    s=miao-h*3600-m*60;
     NSLog(@"s is %d",s);
    return [NSString stringWithFormat:@"%d",abs(s)];
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
    NSString *query1 = @"SELECT * FROM item where iftop=0";
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
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM item where iftop='%d'",1];
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
            NSDictionary *tempDict = @{@"id":id, @"title":title, @"category":category, @"time":time,@"iftop":iftop, @"ifpass":ifpass,@"backimage":backimage,@"ifremind":ifremind,@"music":music};
            itemModel *model = [itemModel AccountModelWithDict:tempDict];
            
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
