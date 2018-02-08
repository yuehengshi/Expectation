//
//  timeZone.m
//  Expectation
//
//  Created by Syh on 16/9/20.
//  Copyright © 2016年 5. All rights reserved.
//

#import "timeZone.h"
#import "worldModel.h"
#import "ThirdViewController.h"
#import "sqlite3.h"
@interface timeZone ()
{
    NSArray* searchData;
    bool isSearch;
}
@property (nonatomic, strong) NSArray *allTimeZones;

@end

@implementation timeZone
- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _city_and_timezone=[NSDictionary dictionaryWithObjectsAndKeys:
                        @"Australia/Darwin", @"澳大利亚/中部",
                        @"Asia/Kabul", @"阿富汗",
                        @"America/Anchorage", @"阿拉斯加",
                        @"Asia/Riyadh", @"科威特",
                        @"Asia/Riyadh", @"利雅得",
                        @"Asia/Baghdad", @"阿拉伯联合酋长国",
                        @"America/Buenos_Aires", @"阿根廷",
                        @"America/Halifax", @"太平洋时间",
                        @"Asia/Baku", @"阿塞拜疆",
                        @"Atlantic/Azores",@"亚速尔群岛",
                        @"America/Bahia", @"萨尔瓦多",
                        @"Asia/Dhaka", @"孟加拉",
                        @"America/Regina", @"加拿大",
                        @"Atlantic/Cape_Verde", @"佛得角",
                        @"Asia/Yerevan", @"亚美尼亚",
                        @"Australia/Adelaide", @"阿德莱德",
                        @"America/Guatemala", @"中美洲",
                        @"Asia/Almaty", @"哈萨克斯坦",
                        @"America/Cuiaba", @"库亚巴",
                        @"Europe/Budapest", @"塞尔维亚",
                        @"Europe/Budapest", @"斯洛伐克",
                        @"Europe/Budapest", @"匈牙利",
                        @"Europe/Budapest", @"斯洛文尼亚",
                        @"Europe/Budapest", @"捷克",
                        @"Europe/Warsaw", @"波斯尼亚-黑赛哥维那",
                        @"Europe/Warsaw", @"马其顿",
                        @"Europe/Warsaw", @"波兰",
                        @"Europe/Warsaw", @"克罗地亚",
                        @"Pacific/Guadalcanal", @"所罗门群岛",
                        @"Pacific/Guadalcanal", @"里新喀多尼亚",
                        @"America/Chicago", @"美国",
                        @"America/Chicago", @"加拿大中部",
                        @"America/Mexico_City", @"墨西哥",
                        @"Asia/Shanghai", @"中国",
                        @"Etc/GMT+12", @"国际日期变更线西",
                        @"Africa/Nairobi", @"肯尼亚",
                        @"Australia/Brisbane", @"澳大利亚东北部",
                        @"Asia/Nicosia", @"东欧",
                        @"America/Sao_Paulo", @"巴西",
                        @"America/New_York", @"美国东部",
                        @"America/New_York", @"加拿大东部",
                        @"Africa/Cairo", @"埃及",
                        @"Asia/Yekaterinburg", @"俄罗斯-叶卡捷琳堡",
                        @"Europe/Kiev", @"芬兰",
                        @"Europe/Kiev", @"乌克兰",
                        @"Europe/Kiev", @"拉脱维亚",
                        @"Europe/Kiev", @"保加利亚",
                        @"Europe/Kiev", @"爱沙尼亚",
                        @"Europe/Kiev", @"立陶宛",
                        @"Pacific/Fiji", @"斐济",
                        @"Europe/London", @"爱尔兰",
                        @"Europe/London", @"苏格兰",
                        @"Europe/London", @"葡萄牙",
                        @"Europe/London", @"英国",
                        @"Europe/Bucharest", @"希腊",
                        @"Europe/Bucharest", @"罗马尼亚",
                        @"Asia/Tbilisi", @"格鲁吉亚",
                        @"America/Godthab", @"格陵兰岛",
                        @"Atlantic/Reykjavik", @"利比里亚",
                        @"Atlantic/Reykjavik", @"冰岛",
                        @"Pacific/Honolulu", @"夏威夷群岛",
                        @"Asia/Calcutta", @"印度",
                        @"Asia/Tehran", @"伊朗",
                        @"Asia/Jerusalem", @"以色列",
                        @"Asia/Jerusalem", @"巴勒斯坦",
                        @"Asia/Amman", @"约旦",
                        @"Europe/Kaliningrad", @"俄罗斯-加里宁格勒",
                        @"Europe/Kaliningrad", @"白俄罗斯",
                        @"Asia/Seoul", @"韩国",
                        @"Indian/Mauritius", @"毛里求斯",
                        @"Asia/Beirut", @"黎巴嫩",
                        @"America/Montevideo", @"乌拉圭",
                        @"Africa/Casablanca", @"摩洛哥",
                        @"America/Denver", @"美国/加拿大山地时间",
                        @"America/Chihuahua", @"玻利维亚",
                        @"Asia/Rangoon", @"缅甸",
                        @"Asia/Novosibirsk", @"俄罗斯-新西伯利亚",
                        @"Africa/Windhoek", @"纳米比亚",
                        @"Asia/Katmandu", @"尼泊尔",
                        @"Pacific/Auckland", @"新西兰-奥克兰",
                        @"Pacific/Auckland", @"新西兰-惠灵顿",
                        @"America/St_Johns", @"纽芬兰",
                        @"Asia/Irkutsk", @"俄罗斯-伊尔库茨克",
                        @"Asia/Krasnoyarsk", @"俄罗斯-克拉斯诺亚尔斯克",
                        @"America/Santiago", @"智利",
                        @"America/Los_Angeles", @"太平洋时间",
                        @"America/Santa_Isabel", @"下加利福尼亚州",
                        @"Asia/Karachi", @"巴基斯坦",
                        @"America/Asuncion", @"巴拉圭",
                        @"Europe/Paris", @"比利时",
                        @"Europe/Paris", @"丹麦",
                        @"Europe/Paris", @"西班牙",
                        @"Europe/Paris", @"法国",
                        @"Europe/Moscow", @"俄罗斯-莫斯科",
                        @"Europe/Moscow", @"俄罗斯-圣彼得堡",
                        @"Europe/Moscow", @"俄罗斯-伏尔加格勒",
                        @"America/Cayenne", @"福塔雷萨",
                        @"America/Bogota", @"哥伦比亚",
                        @"America/Bogota", @"秘鲁",
                        @"America/Bogota", @"厄瓜多尔",
                        @"America/La_Paz", @"圭亚那合作共和国",
                        @"America/La_Paz", @"玻利维亚-拉巴斯",
                        @"America/La_Paz", @"亚马逊洲",
                        @"America/La_Paz", @"阿根廷-圣胡安",
                        @"Asia/Bangkok", @"泰国",
                        @"Asia/Bangkok", @"越南",
                        @"Asia/Bangkok", @"印度尼西亚",
                        @"Pacific/Apia", @"萨摩亚群岛",
                        @"Asia/Singapore", @"新加坡",
                        @"Asia/Singapore", @"马来西亚",
                        @"Africa/Johannesburg", @"津巴布韦",
                        @"Africa/Johannesburg", @"南非",
                        @"Asia/Colombo", @"斯里加亚渥登普拉",
                        @"Asia/Damascus", @"叙利亚",
                        @"Asia/Taipei", @"Taipei Standard Time",
                        @"Australia/Hobart", @"澳大利亚-霍巴特",
                        @"Asia/Tokyo", @"日本",
                        @"Pacific/Tongatapu", @"汤加王国",
                        @"Europe/Istanbul", @"土耳其",
                        @"America/Indianapolis", @"美国东部-印第安那",
                        @"America/Phoenix", @"美国-亚利桑那",
                        @"Etc/GMT", @"协调世界时",
                        @"Etc/GMT-12", @"协调世界时+12",
                        @"Etc/GMT+2", @"协调世界时-02",
                        @"Etc/GMT+11", @"协调世界时-11",
                        @"Asia/Ulaanbaatar", @"蒙古国",
                        @"America/Caracas", @"委内瑞拉",
                        @"Asia/Vladivostok", @"符拉迪沃斯托克",
                        @"Australia/Perth", @"澳大利亚-珀斯",
                        @"Africa/Lagos", @"中非西部",
                        @"Europe/Berlin", @"荷兰",
                        @"Europe/Berlin", @"德国",
                        @"Europe/Berlin", @"瑞士",
                        @"Europe/Berlin", @"意大利",
                        @"Europe/Berlin", @"瑞典",
                        @"Europe/Berlin", @"罗马",
                        @"Europe/Berlin", @"奥地利",
                        @"Europe/Berlin", @"奥地利共和国",
                        @"Asia/Tashkent", @"土库曼斯坦",
                        @"Asia/Tashkent", @"乌兹别克斯坦",
                        @"Pacific/Port_Moresby", @"关岛",
                        @"Pacific/Port_Moresby", @"巴布亚新几内亚",
                        @"Asia/Yakutsk", @"俄罗斯雅库斯特自治共和国", nil];
   
    _country = [[NSArray alloc] initWithObjects: @"澳大利亚/中部",@"阿富汗",@"阿拉斯加",@"科威特",@"利雅得",@"阿拉伯联合酋长国",@"阿根廷",@"太平洋时间",@"阿塞拜疆",@"亚速尔群岛",@"萨尔瓦多",@"孟加拉",@"加拿大",@"佛得角",@"亚美尼亚",@"阿德莱德",@"中美洲",@"哈萨克斯坦",@"库亚巴",@"塞尔维亚",@"斯洛伐克",@"匈牙利",@"斯洛文尼亚",@"捷克",@"波斯尼亚-黑赛哥维那",@"马其顿",@"波兰",@"克罗地亚",@"所罗门群岛",@"里新喀多尼亚",@"美国",@"加拿大中部"@"墨西哥",@"中国",@"国际日期变更线西",@"肯尼亚",@"澳大利亚东北部",@"东欧",@"巴西",@"美国东部",@"加拿大东部",@"埃及",@"俄罗斯-叶卡捷琳堡",@"芬兰",@"乌克兰",@"拉脱维亚",@"保加利亚",@"爱沙尼亚",@"立陶宛",@"斐济",@"爱尔兰",@"苏格兰",@"葡萄牙",@"英国",@"希腊",@"罗马尼亚",@"格鲁吉亚",@"格陵兰岛",@"利比里亚",@"冰岛",@"夏威夷群岛",@"印度",@"伊朗",@"以色列",@"巴勒斯坦",@"约旦",@"俄罗斯-加里宁格勒",@"白俄罗斯",@"韩国",@"毛里求斯",@"黎巴嫩",@"乌拉圭",@"摩洛哥",@"美国/加拿大山地时间",@"玻利维亚",@"缅甸",@"俄罗斯-新西伯利亚",@"纳米比亚",@"尼泊尔",@"新西兰-奥克兰",@"新西兰-惠灵顿",@"纽芬兰",@"俄罗斯-伊尔库茨克",@"俄罗斯-克拉斯诺亚尔斯克",@"智利",@"太平洋时间",@"下加利福尼亚州",@"巴基斯坦",@"巴拉圭",@"比利时",@"丹麦",@"西班牙",@"法国",@"俄罗斯-莫斯科",@"俄罗斯-圣彼得堡",@"俄罗斯-伏尔加格勒",@"福塔雷萨",@"哥伦比亚",@"秘鲁",@"厄瓜多尔",@"圭亚那合作共和国",@"玻利维亚-拉巴斯",@"亚马逊洲",@"阿根廷-圣胡安",@"泰国",@"越南",@"印度尼西亚",@"萨摩亚群岛",@"新加坡",@"马来西亚",@"津巴布韦",@"南非",@"斯里加亚渥登普拉",@"叙利亚",@"澳大利亚-霍巴特",@"日本",@"汤加王国",@"土耳其",@"美国东部-印第安那",@"美国-亚利桑那",@"协调世界时",@"协调世界时+12",@"协调世界时-02",@"协调世界时-11",@"蒙古国",@"委内瑞拉",@"符拉迪沃斯托克",@"澳大利亚-珀斯",@"中非西部",@"荷兰",@"德国",@"瑞士",@"意大利",@"瑞典",@"罗马",@"奥地利",@"奥地利共和国",@"土库曼斯坦",@"乌兹别克斯坦",@"关岛",@"巴布亚新几内亚",@"俄罗斯雅库斯特自治共和国",nil];

        [self ifBlackNav:NO];
    self.searchBar.delegate=self;
        _searchBar.placeholder = @"自己汉化的时区，有可能不全...";
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    _allTimeZones = [NSTimeZone knownTimeZoneNames];
    
}
-(void)backTo{
    UIColor * color1 = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
    [self ifBlackNav:YES];
    self.navigationController.navigationBar.titleTextAttributes=dict;
         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(isSearch)
    {
    return searchData.count;
    }
    else
    {
    return _country.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"TimeZoneCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(isSearch)
    {
        cell.textLabel.text = [searchData objectAtIndex:indexPath.row];
    }
    else{
     
        cell.textLabel.text =  _country[indexPath.row];
    }
    return cell;
}
// UISearchBarDelegate定义的方法，用户单击取消按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // 取消搜索状态
    isSearch = NO;
    [self.tableView reloadData];
}
// UISearchBarDelegate定义的方法，当搜索文本框内文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText  //  —————————— ①
{
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchText];
}
// UISearchBarDelegate定义的方法，用户单击虚拟键盘上Search按键时激发该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar //  —————————— ②
{
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [searchBar resignFirstResponder];
}
- (void) filterBySubstring:(NSString*) subStr  //  —————————— ③
{
    // 设置为搜索状态
    isSearch = YES;
    // 定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"SELF CONTAINS[c] %@" , subStr];
    // 使用谓词过滤NSArray
    searchData = [_country filteredArrayUsingPredicate:pred];
    // 让表格控件重新加载数据
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *timezone;
    NSString *country;
    if(isSearch)
    {
         timezone = [_city_and_timezone objectForKey:[searchData objectAtIndex:indexPath.row]];
        country =[searchData objectAtIndex:indexPath.row];
    }
    else{
       timezone = [_city_and_timezone objectForKey:[_country objectAtIndex:indexPath.row]];
        country =[_country objectAtIndex:indexPath.row];
    }
       sqlite3 *database;
    sqlite3_stmt *stmt;
    char *errorMsg = NULL;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)
        != SQLITE_OK) {
        NSLog(@"false");
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }

    NSString *insert = [NSString stringWithFormat:@"insert into world (timezone,country) values ('%@','%@')",timezone,country];
    NSLog(@"%@",insert);
    
    
    sqlite3_prepare_v2(database, [insert UTF8String], -1, &stmt, NULL);
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
        NSAssert(0, @"Error inserting table: %s", errorMsg);
    sqlite3_finalize(stmt);
    
    sqlite3_close(database);
    UIColor * color1 = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
    [self ifBlackNav:YES];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];

}

-(void)ifBlackNav:(BOOL)value{
    if(value){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"gray"] forBarMetrics:0];
    }
    else{
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"white"] forBarMetrics:0];
    }
}
@end
