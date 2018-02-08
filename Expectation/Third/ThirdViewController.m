//
//  ThirdViewController.m
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import "ThirdViewController.h"
#import "SPClockView.h"
#import "timeZone.h"
#import "worldModel.h"
#import "sqlite3.h"
#import "RNFrostedSidebar.h"
#import "Login.h"
#import "Download.h"
#import "Register.h"
#import "Advice.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "Login_5s.h"
#import "Advice_5s.h"
#import "Download_5s.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define clockViewTag        12345
#define clockLabelTag       23456
#define digitalClockTag     34567
#define xPadding             20
#define yPadding             5
@interface ThirdViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int count;
    int side_selection;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) SPClockView *clockView;
@property (nonatomic, strong) NSMutableArray *timeZones;
@property (nonatomic, strong) NSArray *allTimeZones;
@property (strong, nonatomic) worldModel *worldModel;
@property (strong, nonatomic)NSArray *detailArray;


@end

@implementation ThirdViewController
static NSString * const reuseIdentifier1 = @"WordCell";
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.tableView.showsVerticalScrollIndicator =NO;
    [self initTableView];
    [self ifBlackNav:YES];
    _alert = [[UILabel alloc]init];
   
  //  _alert.font = [ UIFont fontWithName:@"Arial" size:25];
    _alert.textColor = [ UIColor whiteColor];
    _alert.numberOfLines = 0;
    _alert.text=@"请点击右上角按钮添加世界时钟";
     [_alert sizeToFit];
    _alert.textAlignment =UITextAlignmentCenter;
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _timeZones = [NSMutableArray new];
    
  //  [_timeZones addObject:[NSTimeZone localTimeZone]];
    

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimeZone:)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menu)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
   

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self initTableView];
    [self.tableView reloadData];
    if(count==0)
    {
    [self.tableView addSubview:_alert];
        [_alert mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.view.mas_left).offset(0);
             make.right.equalTo(self.view.mas_right).offset(0);
             make.top.equalTo(self.view.mas_top).offset(60);
             make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
         }];
        NSLog(@"%f",SCREEN_HEIGHT);
    }
    else{
        [_alert removeFromSuperview ];
    }
}
- (void)initTableView
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
        NSString *query1 = @"SELECT * FROM world ";
        if (sqlite3_prepare_v2(database, [query1 UTF8String],-1, &statement, nil) == SQLITE_OK)
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
            _detailArray = modelArr;
            count=(int)_detailArray.count;
            sqlite3_finalize(statement);
        }
       sqlite3_close(database);
    }
}

- (void)addTimeZone:(UIBarButtonItem *)sender{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    timeZone *vc = (timeZone*)[storyboard instantiateViewControllerWithIdentifier:@"timeZone"];

    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    worldModel *model=_detailArray[indexPath.row];
    
   
         NSString *CellIdentifier = @"ClockCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            SPClockView *clockView = [[SPClockView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
            [cell.contentView addSubview:clockView];
            clockView.tag = clockViewTag;
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 50, cell.contentView.frame.size.width, 40)];
            name.backgroundColor = [UIColor clearColor];
            name.textAlignment = NSTextAlignmentCenter;
            name.tag = clockLabelTag;
            [cell.contentView addSubview:name];
            SPDigitalClock *digitalClock = [[SPDigitalClock alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 50)];
            digitalClock.tag = digitalClockTag;
            [cell.contentView addSubview:digitalClock];
        }
        NSTimeZone *tz = [NSTimeZone timeZoneWithName:model.timezone];
        SPClockView *clockView = (SPClockView *)[cell.contentView viewWithTag:clockViewTag];
        UILabel *clockNameLabel = (UILabel *)[cell.contentView viewWithTag:clockLabelTag];
        SPDigitalClock *digitalClock = (SPDigitalClock *)[cell.contentView viewWithTag:digitalClockTag];
        if([clockNameLabel isKindOfClass:[UILabel class]]){
            clockNameLabel.text = model.country;
            NSLog(@"%@",model.country);
            clockNameLabel.font = [ UIFont fontWithName:@"Arial" size:20];
            clockNameLabel.frame = CGRectMake(0, 5, cell.contentView.frame.size.width, 20);
        }
        if(clockView && [clockView isKindOfClass:[SPClockView class]]){
            [clockView setTimeZone:tz];
            clockView.frame = CGRectMake(CGRectGetMidX(cell.contentView.frame)-CGRectGetWidth(clockView.frame)/2, CGRectGetMaxY(clockNameLabel.frame)+yPadding, clockView.frame.size.width, clockView.frame.size.width);
        }
        if(digitalClock && [digitalClock isKindOfClass:[SPDigitalClock class]]){
            [digitalClock setTimeZone:tz];
            digitalClock.frame = CGRectMake(0, CGRectGetMaxY(clockView.frame)+yPadding, cell.contentView.frame.size.width, 30);
        }
//    if([_if_night isEqual:@"0"])
//    {
//        NSLog(@"当前是白天");
//    }
//    else if([_if_night isEqual:@"1"])
//    {
//         NSLog(@"当前是黑天");
//    }
//    
    
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208.0 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
   

}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        worldModel *model = _detailArray[indexPath.row];
        [self deleteClockWithID:[model.id intValue]];
        [self initTableView];
        [self.tableView reloadData];
        [tableView setEditing:NO animated:YES];
    }
                                        
];
    deleteAction.backgroundColor =[UIColor redColor];
    return @[deleteAction];
}
-(void)deleteClockWithID:(int)ID
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
        NSString *deleteRow = [[NSString alloc]initWithFormat:@"DELETE FROM world WHERE id='%d'",ID];
        sqlite3_exec(database, [deleteRow UTF8String], NULL, NULL, &errmsg);
        NSLog(@"%s",errmsg);
        sqlite3_close(database);
        
    }

}
-(void)ifBlackNav:(BOOL)value{
    if(value){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"gray"] forBarMetrics:0];
    }
    else{
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white"] forBarMetrics:0];
    }
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
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {

    
    if(side_selection==0)
    {  NSLog(@"点击了第一个侧边栏" );
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        [self ifTransparentNav:YES];
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
        [self ifTransparentNav:YES];
        if([[AppDelegate deviceVersion] isEqual:@"iPhone 5S"])
        {
            Download_5s *vc = (Download_5s*)[storyboard instantiateViewControllerWithIdentifier:@"Download_5s"];
            
            [self.navigationController pushViewController:vc animated:YES];

        }
        else{
            Download *vc = (Download*)[storyboard instantiateViewControllerWithIdentifier:@"Download"];
            
            [self.navigationController pushViewController:vc animated:YES];

        }
            }
    else
    {    NSLog(@"点击了第三个侧边栏" );
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        [self ifTransparentNav:YES];
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
   }

@end
