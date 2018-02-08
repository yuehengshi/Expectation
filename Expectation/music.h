//
//  music.h
//  Expectation
//
//  Created by Syh on 16/9/16.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface music : UITableViewController
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *music;
@property (strong, nonatomic) NSString *ifremind_data;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *title_data;
@property (strong, nonatomic) NSString *hour_data;
@property (strong, nonatomic) NSString *min_data;
@property (strong, nonatomic) NSString *sec_data;
@property (strong, nonatomic) NSString *iftop_data;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) IBOutlet NSString *modelIndex;
@property (strong, nonatomic) IBOutlet NSString *if_UISwitch_enable;
@property (strong, nonatomic) NSString *ifedit;
@property (strong, nonatomic) NSString *current_page;
@property (strong, nonatomic) NSString *time_data;
@property (strong, nonatomic) NSString *time_string;
@property (strong, nonatomic) NSMutableArray *temp_imagePath;
@property (assign, nonatomic) int imgNum;
@end
