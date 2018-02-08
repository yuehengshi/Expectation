//
//  addNew.h
//  Expectation
//
//  Created by Syh on 16/9/19.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface addNew : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    sqlite3 *dataBase;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UITextField *title_input;
@property (strong, nonatomic) IBOutlet UILabel *top_status;
@property (strong, nonatomic) IBOutlet UILabel *top_day;
@property (strong, nonatomic) IBOutlet UIImageView *top_pic;
@property (strong, nonatomic) IBOutlet UILabel *top_title;
@property (strong, nonatomic) IBOutlet UIImageView *top_back;


@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwitch *iftop;
@property (strong, nonatomic) IBOutlet UISwitch *ifremind;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *musicLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *time;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) NSMutableArray *temp_imagePath;
@property (assign, nonatomic) int imgNum;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *time_data;
@property (strong, nonatomic) NSString *hour_data;
@property (strong, nonatomic) NSString *min_data;
@property (strong, nonatomic) NSString *sec_data;
@property (strong, nonatomic) NSString *title_data;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *music;
@property (strong, nonatomic) NSString *count;
@property (strong, nonatomic) NSString *iftop_data;
@property (strong, nonatomic) NSString *ifremind_data;
@property (strong, nonatomic) NSString *ifedit;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) IBOutlet NSString *modelIndex;
@property (strong, nonatomic) IBOutlet NSString *if_UISwitch_enable;
@property(nonatomic,copy)NSDate *resultString_date;
@property (strong, nonatomic) NSString *current_page;
@property (strong, nonatomic) NSString *time_string;
@end
