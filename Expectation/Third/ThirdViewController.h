//
//  ThirdViewController.h
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "RNGridMenu.h"
@interface ThirdViewController : UITableViewController<RNGridMenuDelegate>
@property (strong, nonatomic) IBOutlet UILabel *alert;
@property (strong, nonatomic) NSString *if_night;
@end
