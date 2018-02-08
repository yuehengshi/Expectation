//
//  FirstViewController.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//
#import "NavigationController.h"
#import "FirstViewController.h"
#import "itemModel.h"
#import "topCell1.h"
#import "bottomCell1.h"
#import "addNewAffairTableViewController.h"
#import "singleDisplay.h"
#import "MainTabBarController.h"
#import "RNFrostedSidebar.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "topCell1_5s.h"
#import "bottomCell1_5s.h"
#import "Login_5s.h"
#import "Advice_5s.h"
#import "Download_5s.h"
#import "Login.h"
#import "Download.h"
#import "Advice.h"
#import "singleDisplay_5s.h"
#import "UzysSlideMenu.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7
@interface FirstViewController ()
{
    int count;
    int side_selection;
 NSTimer *timer;
    int cell_height;
}
@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (strong, nonatomic)itemModel *itemModel;
@property (strong, nonatomic)NSString *inStr;
@property (strong, nonatomic)NSString *outStr;
@property (strong, nonatomic)NSArray *detailArray;
@property (strong, nonatomic) NSArray *detailArray1;
@property (strong, nonatomic)topCell1 *cellForHeader;
@property (strong, nonatomic)topCell1_5s *cellForHeader_5s;
@end

@implementation FirstViewController
static NSString * const reuseIdentifier1 = @"topCell1";
static NSString * const reuseIdentifier1_5s = @"topCell1_5s";
static NSString * const reuseIdentifier2 = @"bottomCell1";
static NSString * const reuseIdentifier2_5s = @"bottomCell1_5s";
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator =NO;
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    _current_page=@"1";
    [self initTableView];
    [timer invalidate];
    if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
    {[self.tableView registerNib:[UINib nibWithNibName:@"topCell1_5s" bundle:nil]
          forCellReuseIdentifier:reuseIdentifier1_5s];
        [self.tableView registerNib:[UINib nibWithNibName:@"bottomCell1_5s" bundle:nil]  forCellReuseIdentifier:reuseIdentifier2_5s];
        cell_height=55;
        
    }
    else
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"topCell1" bundle:nil]  forCellReuseIdentifier:reuseIdentifier1];
        [self.tableView registerNib:[UINib nibWithNibName:@"bottomCell1" bundle:nil]  forCellReuseIdentifier:reuseIdentifier2];
        cell_height=70;
    }

    timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+165+137-(count)*cell_height) ];
    _imageView.image = [UIImage imageNamed:@"back1"];
    [self.view addSubview:_imageView];
    _transparent_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-(count*cell_height)) ];
    [_transparent_btn addTarget:self action:@selector(toSingleDisplay) forControlEvents:UIControlEventTouchUpInside];
    _transparent_btn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_transparent_btn];
    [self.view bringSubviewToFront:_transparent_btn];
    
//    _menuBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20) ];
//    [_menuBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
//    _menuBtn.backgroundColor=[UIColor blackColor];
//    [self.view addSubview:_menuBtn];

   
    self.tableView.separatorStyle = YES;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self initNavigationButton];
      [self.tableView reloadData];
    [self popViewInit];
}
-(void)openMenu{
     [self.uzysSMenu toggleMenu];
}
-(void)popViewInit{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view.frame = frame;
//    self.scrollView.frame = self.view.bounds;
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.imageView.bounds.size.height);
//    self.scrollView.delegate =self;
//    
    
    ah__block typeof(self) blockSelf = self;
    UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:@"全部" image:[UIImage imageNamed:@"a0.png"] action:^(UzysSMMenuItem *item) {
        
        
           }];
    
    UzysSMMenuItem *item1 = [[UzysSMMenuItem alloc] initWithTitle:@"已超出时间" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
        
        
    }];
    UzysSMMenuItem *item2 = [[UzysSMMenuItem alloc] initWithTitle:@"未超出时间" image:[UIImage imageNamed:@"a2.png"] action:^(UzysSMMenuItem *item) {
     
        
        
    }];
    item0.tag = 0;
    item1.tag = 1;
    item2.tag = 2;
    
    NSInteger statusbarHeight = 0;
    if(IS_IOS7)
        statusbarHeight = 20;
    
    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1,item2]];
    self.uzysSMenu.frame = CGRectMake(self.uzysSMenu.frame.origin.x, 0, SCREEN_WIDTH, self.uzysSMenu.frame.size.height);
    
    [self.view addSubview:self.uzysSMenu];
   
    

}
- (void)multiThread {
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
    

}

-(void)toSingleDisplay
{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
     if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
     {
         singleDisplay_5s *vc = (singleDisplay_5s*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay_5s"];
         vc.iftop=@"1";
         vc.current_page=_current_page;
         [timer setFireDate:[NSDate distantFuture]];
         [self.navigationController pushViewController:vc animated:YES];
     }
     else{
         singleDisplay *vc = (singleDisplay*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay"];
         vc.iftop=@"1";
         vc.current_page=_current_page;
         [timer setFireDate:[NSDate distantFuture]];
         [self.navigationController pushViewController:vc animated:YES];
     }
   
}
-(void)timerFireMethod
{
   // NSLog(@"timer");
    @synchronized(self)
    
    {
    [self decreaseTime];
    [self initTableView];
    [self.tableView reloadData];
    }
}
-(void)decreaseTime
{
    if (_detailArray.count > 0)
    {
        for( int i=1;i<count;i++)
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
  
    itemModel * model;
        sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"false3");

//        NSAssert(0, @"Failed to open database");
    }
    else
    {
    
    if(iftop)
    { model = _detailArray1[n];
    }
    else{
        model = _detailArray[n];
    }
    
 //   char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    NSString *update = [NSString stringWithFormat:@"update item set time='%@' where id='%d'",[NSString stringWithFormat:@"%d",[model.time intValue]-1],ID];
    
    sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
   // NSLog(@"%d", result);
//    if (result == SQLITE_OK) {
//        
//    }
    if (sqlite3_step(stmt) == SQLITE_DONE)
//        NSAssert(0, @"Error updating table: %s", errorMsg);
    { sqlite3_finalize(stmt);
    sqlite3_close(database);
        

    }
    }
    
}
-(void)updateIfpass:(int)ID
{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false4");
        sqlite3_close(database);
      //  NSAssert(0, @"Failed to open database");
    }
    else{
//    char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    NSString *update = [NSString stringWithFormat:@"update item set ifpass=1 where id='%d'",ID];
    
    int result = sqlite3_prepare_v2(database, [update UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
    }
    if (sqlite3_step(stmt) == SQLITE_DONE)
//       NSAssert(0, @"Error updating table: %s", errorMsg);
    {
    sqlite3_finalize(stmt);
    sqlite3_close(database);
    }
    }

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // [_timer setFireDate:[NSDate distantFuture]];
    addNewAffairTableViewController *vc=segue.destinationViewController;
    vc.count=[NSString stringWithFormat:@"%d",count];
    
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
-(void)initDatabase
{
    sqlite3 *database;
    sqlite3_stmt *statement;

    NSString *docsDir;
    NSArray *dirPaths;
    char *errorMsg = NULL;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"data.db"]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:databasePath] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &dataBase)==SQLITE_OK) {
            char *errmsg;
            const char *createsql = "CREATE TABLE IF NOT EXISTS item (id integer NOT NULL PRIMARY KEY AUTOINCREMENT,title varchar DEFAULT 无标题,category varchar DEFAULT 无,time varchar,iftop integer DEFAULT 0,ifpass integer DEFAULT 0,backimage varchar,ifremind integer,music varchar DEFAULT 无音乐)";
             const char *createsql2 = "CREATE TABLE IF NOT EXISTS day (id integer NOT NULL PRIMARY KEY AUTOINCREMENT,title varchar DEFAULT 无标题,category varchar DEFAULT 无,time varchar,iftop integer DEFAULT 0,ifpass integer DEFAULT 0,backimage varchar,ifremind integer,music varchar DEFAULT 无音乐,interval varchar)";
            const char *createsql3 = "CREATE TABLE IF NOT EXISTS world (id integer NOT NULL PRIMARY KEY AUTOINCREMENT,timezone varchar,country varchar)";
            sqlite3_exec(dataBase, createsql2, NULL, NULL, &errmsg);
            sqlite3_exec(dataBase, createsql3, NULL, NULL, &errmsg);

            if (sqlite3_exec(dataBase, createsql, NULL, NULL, &errmsg)!=SQLITE_OK) {
                NSLog( @"create table failed.");
            }
        }
        else {
            NSLog(@"create/open failed.");
        }
        if (sqlite3_open([[self dataFilePath] UTF8String], &database)
            != SQLITE_OK) {
            NSLog(@"false2");
            sqlite3_close(database);
   //         NSAssert(0, @"Failed to open database");
        }
        else{
            NSDate *today=[NSDate date];
            NSString *time = [NSString stringWithFormat:@"%ld",(long)[today timeIntervalSince1970]];
        NSString *insert =@"insert into item (title, category,time,iftop,ifpass,backimage,ifremind,music) values ('无效无效无效', '无效无效无效','3600', 0,0, 'back1',0,'无')";
        NSString *insert2 =@"insert into item (title, category,time,iftop,ifpass,backimage,ifremind,music) values ('欢迎使用Expectation', '纪念日','3600', 1,0, 'back1',0,'无')";
        NSString *insert3 =@"insert into day (title, category,time,iftop,ifpass,backimage,ifremind,music,interval) values ('无效无效无效', '无效无效无效','3600', 0,0, 'back1',0,'无','0')";
        NSString *insert4 =[NSString stringWithFormat:@"insert into day (title, category,time,iftop,ifpass,backimage,ifremind,music,interval) values ('欢迎使用Expectation', '纪念日','%@', 1,0, 'back8',0,'无','0')",time];
        NSLog(@"%@",insert);
        sqlite3_prepare_v2(database, [insert UTF8String], -1, &statement, NULL);
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_prepare_v2(database, [insert2 UTF8String], -1, &statement, NULL);
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_prepare_v2(database, [insert3 UTF8String], -1, &statement, NULL);
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_prepare_v2(database, [insert4 UTF8String], -1, &statement, NULL);
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(0, @"Error inserting table: %s", errorMsg);
        sqlite3_finalize(statement);
     sqlite3_close(database);
        }
        
    }
    

    
    sqlite3_close(dataBase);

}
- (void)initTableView
{
    [self initDatabase];
    sqlite3 *database;
    sqlite3_stmt *statement;

    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false1");
        sqlite3_close(database);
//        NSAssert(0, @"Failed to open database");
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
        count = (int)_detailArray.count;
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
-(void)viewWillAppear:(BOOL)animated
{
    [timer setFireDate:[NSDate distantPast]];
    [self.view bringSubviewToFront:_transparent_btn];
   // self.view sendSubviewToBack:<#(nonnull UIView *)#>
    [self initTableView];
    [self.tableView reloadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    //[_timer setFireDate:[NSDate distantFuture]];
    //[timer invalidate];
//     [timer setFireDate:[NSDate distantFuture]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *baseCell = nil;
    if (indexPath.section == 0) {
         if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
         {
             bottomCell1_5s *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2_5s forIndexPath:indexPath];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             if (_detailArray.count > 0) {
                 itemModel * model = _detailArray[indexPath.row];
                 if([model.ifpass isEqual:@"0"])
                 {
                     cell.status.image=[UIImage imageNamed:@"green"];
                 }
                 else
                 {
                     cell.status.image=[UIImage imageNamed:@"red"];
                     
                 }
                 if([model.category  isEqual:@"生日"])
                     cell.pic.image=[UIImage imageNamed:@"生日"];
                 if([model.category  isEqual:@"节日"])
                     cell.pic.image=[UIImage imageNamed:@"节日"];
                 if([model.category  isEqual:@"纪念日"])
                     cell.pic.image=[UIImage imageNamed:@"纪念日"];
                 if([model.category  isEqual:@"学校"])
                     cell.pic.image=[UIImage imageNamed:@"学校"];
                 if([model.category  isEqual:@"考试"])
                     cell.pic.image=[UIImage imageNamed:@"考试"];
                 if([model.category isEqual:@"生活"])
                     cell.pic.image=[UIImage imageNamed:@"生活"];
                 
                 cell.title.text = model.title;
                 cell.time.text = [self SecToTime:model.time ];
             }
             baseCell = cell;

            
         }
         else{
             bottomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2 forIndexPath:indexPath];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             if (_detailArray.count > 0) {
                 itemModel * model = _detailArray[indexPath.row];
                 if([model.ifpass isEqual:@"0"])
                 {
                     cell.status.image=[UIImage imageNamed:@"green"];
                 }
                 else
                 {
                     cell.status.image=[UIImage imageNamed:@"red"];
                     
                 }
                 if([model.category  isEqual:@"生日"])
                     cell.pic.image=[UIImage imageNamed:@"生日"];
                 if([model.category  isEqual:@"节日"])
                     cell.pic.image=[UIImage imageNamed:@"节日"];
                 if([model.category  isEqual:@"纪念日"])
                     cell.pic.image=[UIImage imageNamed:@"纪念日"];
                 if([model.category  isEqual:@"学校"])
                     cell.pic.image=[UIImage imageNamed:@"学校"];
                 if([model.category  isEqual:@"考试"])
                     cell.pic.image=[UIImage imageNamed:@"考试"];
                 if([model.category isEqual:@"生活"])
                     cell.pic.image=[UIImage imageNamed:@"生活"];
                 
                 cell.title.text = model.title;
                 cell.time.text = [self SecToTime:model.time ];
             }
             baseCell = cell;

         }
            }
    
    return baseCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return cell_height;
       
    }
    else
    {
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       itemModel * model = _detailArray[indexPath.row];
    if(indexPath.row!=0)
    {
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            singleDisplay_5s *vc = (singleDisplay_5s*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay_5s"];
            vc.status_data=model.ifpass;
            vc.time_data=[self SecToTime:model.time];
            vc.pic_data=model.category;
            vc.back=model.backimage;
            vc.theme_data=model.title;
            vc.iftop=@"0";
            vc.modelIndex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            vc.current_page=_current_page;
            [timer setFireDate:[NSDate distantFuture]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            singleDisplay *vc = (singleDisplay*)[storyboard instantiateViewControllerWithIdentifier:@"singleDisplay"];
            vc.status_data=model.ifpass;
            vc.time_data=[self SecToTime:model.time];
            vc.pic_data=model.category;
            vc.back=model.backimage;
            vc.theme_data=model.title;
            vc.iftop=@"0";
            vc.modelIndex=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            vc.current_page=_current_page;
            [timer setFireDate:[NSDate distantFuture]];
            [self.navigationController pushViewController:vc animated:YES];
        }
   
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

 //   [timer setFireDate:[NSDate distantFuture]];
    //[NSThread sleepForTimeInterval:2];
//    NSTimer *timer1=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delay) userInfo:nil repeats:YES];

        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        itemModel *model = _detailArray[indexPath.row];
    
        [self deleteAccountDetailWithID:model.category title:model.title time_data:model.time ID:[model.id intValue]];
            if (![model.backimage containsString:@"back"])
            {
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSFileManager *fm=[NSFileManager defaultManager];
                NSString *filepath=[paths[0] stringByAppendingPathComponent:model.backimage];
                [fm removeItemAtPath:filepath error:nil];
            }
        [self initTableView];
        [self.tableView reloadData];
        [tableView setEditing:NO animated:YES];
    }
    ];
    deleteAction.backgroundColor =[UIColor redColor];
    
    //[timer setFireDate:[NSDate distantPast]];
    return @[deleteAction];
}
-(void)delay{
    [timer setFireDate:[NSDate distantPast]];
    NSLog(@"fasdfd");

}
- (void)deleteAccountDetailWithID:(NSString *)category title:(NSString*)title time_data:(NSString*)time_data ID:(int)ID
{
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false6");
        sqlite3_close(database);
   //     NSAssert(0, @"Failed to open database");
    }
    else{
    char *errmsg;
    NSString *deleteRow = [[NSString alloc]initWithFormat:@"DELETE FROM item WHERE category = '%@' and title='%@' and id='%d'" ,category,title,ID];
    sqlite3_exec(database, [deleteRow UTF8String], NULL, NULL, &errmsg);
    NSLog(@"%s",errmsg);
    sqlite3_close(database);
        
    }
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSLog(@"%@",notifications);
    }];

    [center removePendingNotificationRequestsWithIdentifiers: @[title]];
    
  //  [center removeAllPendingNotificationRequests];
        [center removeDeliveredNotificationsWithIdentifiers:@[title] ];
    [center removeAllDeliveredNotifications];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {_cellForHeader_5s = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1_5s ];
            UIView *headerView = [[UIView alloc]init];
            headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            _cellForHeader_5s.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
            if(_detailArray1.count >0) {
                itemModel * model = _detailArray1[0];
                if([model.ifpass isEqual:@"0"])
                {
                    _cellForHeader_5s.status.text=@"还剩";
                }
                else
                {
                    _cellForHeader_5s.status.text=@"已超过";
                }
                if([model.category  isEqual:@"生日"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"shengri"];
                if([model.category  isEqual:@"节日"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"jieri"];
                if([model.category  isEqual:@"纪念日"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"jinianri"];
                if([model.category  isEqual:@"学校"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"xuexiao"];
                if([model.category isEqual:@"考试"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"kaoshi"];
                if([model.category  isEqual:@"生活"])
                    _cellForHeader_5s.pic.image=[UIImage imageNamed:@"shenghuo"];
                _cellForHeader_5s.title.text = model.title;
                _cellForHeader_5s.time.text = [self SecToTime:model.time ];
                headerView.backgroundColor=[UIColor clearColor];
                _cellForHeader_5s.backgroundColor=[UIColor clearColor];
                [_imageView setFrame:CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+165+135-(count)*cell_height) ];
                _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.backimage]];
                [_transparent_btn setFrame:CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+165+135-(count)*cell_height)];
                [self.view bringSubviewToFront:_transparent_btn];
                
            }
            
            
            // sqlite3_close(dataBase);
            [headerView addSubview:_cellForHeader_5s];
            return headerView;
                    }
        else
        {
            _cellForHeader = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1 ];
            UIView *headerView = [[UIView alloc]init];
            headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            _cellForHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
            if(_detailArray1.count >0) {
                itemModel * model = _detailArray1[0];
                if([model.ifpass isEqual:@"0"])
                {
                    _cellForHeader.status.text=@"还剩";
                }
                else
                {
                    _cellForHeader.status.text=@"已超过";
                }
                if([model.category  isEqual:@"生日"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"shengri"];
                if([model.category  isEqual:@"节日"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"jieri"];
                if([model.category  isEqual:@"纪念日"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"jinianri"];
                if([model.category  isEqual:@"学校"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"xuexiao"];
                if([model.category isEqual:@"考试"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"kaoshi"];
                if([model.category  isEqual:@"生活"])
                    _cellForHeader.pic.image=[UIImage imageNamed:@"shenghuo"];
                _cellForHeader.title.text = model.title;
                _cellForHeader.time.text = [self SecToTime:model.time ];
                headerView.backgroundColor=[UIColor clearColor];
                _cellForHeader.backgroundColor=[UIColor clearColor];
                [_imageView setFrame:CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+165+137-(count)*cell_height) ];
                if ([model.backimage containsString:@"back"]) {
                    _imageView.image=[UIImage imageNamed:model.backimage];
                }
                else{
                    //_imageView.image=[UIImage imageWithContentsOfFile:model.backimage];
                    _imageView.image=[UIImage imageWithContentsOfFile:[self addPath:model.backimage ]];
                }
           //     _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.backimage]];
                [_transparent_btn setFrame:CGRectMake(0, -300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+165+137-(count)*cell_height)];
                [self.view bringSubviewToFront:_transparent_btn];
                
            }
            
            
            // sqlite3_close(dataBase);
            [headerView addSubview:_cellForHeader];
            return headerView;

        }
        

        
    }
    else
    {
        return nil;
    }
}
-(NSString*)addPath:(NSString*)path{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *temp=[paths[0] stringByAppendingPathComponent:path];
    return  temp;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
       
        return [UIScreen mainScreen].bounds.size.height-(count)*cell_height-cell_height;
           }
    else
    {
        return 0.f;
    }
}
-(void)initNavigationButton{
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(right)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menu)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];

}
-(void)menu{

    NSArray *images = @[[UIImage imageNamed:@"上传"],
                        [UIImage imageNamed:@"下载"],
                        [UIImage imageNamed:@"建议"],
                        ];
 
    NSArray *colors = @[[UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
//                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
//                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
//                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
//                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
//                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
//                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
//                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
//                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
//                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    [callout show];

}
- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        [sidebar dismissAnimated:YES completion:nil];
        [self showGrid:index];
    }
    if (index == 1) {
        [sidebar dismissAnimated:YES completion:nil];
        [self showGrid:index];
    }
    if (index == 2) {
        [sidebar dismissAnimated:YES completion:nil];
        [self showGrid:index];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}
-(void)right{
    if(count <=5){
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    addNewAffairTableViewController *vc = (addNewAffairTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"addNew1"];
        vc.ifedit=@"0";
        vc.current_page=_current_page;
        [self.navigationController pushViewController:vc animated:YES];}
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"暂时不能添加" message:@"请删除无用的事件后再尝试添加" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    //  NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
//if(itemIndex==0)
        [self.view bringSubviewToFront:_transparent_btn];
     [timer setFireDate:[NSDate distantPast]];
       if(side_selection==0)
       {  NSLog(@"点击了第一个侧边栏" );
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
           if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
           {
               Login_5s *vc = (Login_5s*)[storyboard instantiateViewControllerWithIdentifier:@"Login_5s"];
               [self.navigationController pushViewController:vc animated:YES];

           }
           else{
               Login *vc = (Login*)[storyboard instantiateViewControllerWithIdentifier:@"Login"];
               [self.navigationController pushViewController:vc animated:YES];

           }
               }
    else if(side_selection==1)
    { NSLog(@"点击了第二个侧边栏" );
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {
            Download_5s *vc = (Download_5s*)[storyboard instantiateViewControllerWithIdentifier:@"Download_5s"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            Download *vc = (Download*)[storyboard instantiateViewControllerWithIdentifier:@"Download"];
            [timer setFireDate:[NSDate distantFuture]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else
    {    NSLog(@"点击了第三个侧边栏" );
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {
            Advice_5s *vc = (Advice_5s*)[storyboard instantiateViewControllerWithIdentifier:@"Advice_5s"];
            [self.navigationController pushViewController:vc animated:YES];

        }
        else{
            Advice *vc = (Advice*)[storyboard instantiateViewControllerWithIdentifier:@"Advice"];
            [self.navigationController pushViewController:vc animated:YES];

        }
           }
}
-(void)gridMenuWillDismiss:(RNGridMenu *)gridMenu{
    [self.view bringSubviewToFront:_transparent_btn];
     [timer setFireDate:[NSDate distantPast]];
    NSLog(@"点击了其他地方" );
}
- (void)showGrid:(NSUInteger)index{
    NSInteger numberOfOptions = 1;
    NSArray *items;
    if(index==0)
    {
        side_selection=0;
        items = @[[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"上传"] title:@"点击开始备份"]];}
    if(index==1)
    {
        side_selection=1;
        items = @[[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"下载"] title:@"点击下载备份"]];}
    if(index==2)
    {
        side_selection=2;
        items = @[[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"建议"] title:@"提出您的建议"]];}
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
      av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
    [timer setFireDate:[NSDate distantFuture]];
     [self.view sendSubviewToBack:_transparent_btn];
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

@end
