//
//  single_5s.h
//  Expectation
//
//  Created by Syh on 16/9/26.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface single_5s : UIViewController
{
    sqlite3 *dataBase;
    NSString *databasePath;
}
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *theme;


@property (strong, nonatomic) IBOutlet NSString *back;
@property (strong, nonatomic) IBOutlet NSString *status_data;
@property (strong, nonatomic) IBOutlet NSString *time_data;
@property (strong, nonatomic) IBOutlet NSString *pic_data;
@property (strong, nonatomic) IBOutlet NSString *theme_data;
@property (strong, nonatomic) IBOutlet NSString *iftop;
@property (strong, nonatomic) IBOutlet NSString *modelIndex;
@property (strong, nonatomic) IBOutlet NSString *if_UISwitch_enable;
@property (strong, nonatomic) NSString *current_page;
@property (strong, nonatomic) NSString *time_string;

@end
