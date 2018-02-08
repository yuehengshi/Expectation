//
//  addNewAffairTableViewController.h
//  Expectation
//
//  Created by Syh on 16/8/28.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface addNewAffairTableViewController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    sqlite3 *dataBase;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UITextField *title_input;
@property (strong, nonatomic) IBOutlet UILabel *top_status;
@property (strong, nonatomic) IBOutlet UILabel *top_time;
@property (strong, nonatomic) IBOutlet UIImageView *top_pic;
@property (strong, nonatomic) IBOutlet UILabel *top_title;
@property (strong, nonatomic) IBOutlet UIImageView *top_back;

@property (strong, nonatomic) IBOutlet UITextField *hour;
@property (strong, nonatomic) IBOutlet UITextField *min;
@property (strong, nonatomic) IBOutlet UITextField *sec;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwitch *iftop;
@property (strong, nonatomic) IBOutlet UISwitch *ifremind;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *musicLabel;
@property (strong, nonatomic) NSMutableArray *temp_imagePath;
@property (assign, nonatomic) int imgNum;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *image_full;
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
@property (strong, nonatomic) NSString *current_page;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) IBOutlet NSString *modelIndex;
@property (strong, nonatomic) IBOutlet NSString *if_UISwitch_enable;
@end
