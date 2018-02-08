//
//  SecondViewController.h
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "RNGridMenu.h"
@interface SecondViewController : UITableViewController<RNGridMenuDelegate>

{
    sqlite3 *dataBase;
    NSString *databasePath;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *transparent_btn;
@property (strong, nonatomic) NSString *current_page;
@end
