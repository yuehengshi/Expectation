//
//  Login_5s.h
//  Expectation
//
//  Created by Syh on 16/9/25.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemModel.h"
#import "NetTools.h"
#import "dayModel.h"
#import "worldModel.h"
@interface Login_5s : UIViewController
- (IBAction)backup:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic)itemModel *itemModel;
@property (strong, nonatomic)dayModel *dayModel;
@property (strong, nonatomic)worldModel *worldModel;
@property (strong, nonatomic)NSString *num;
@property (strong, nonatomic)NSArray *detailArray;
@property (strong, nonatomic)NSArray *detailArray1;
@property (strong, nonatomic)NSArray *detailArray2;
@property (nonatomic,strong) NetTools *net;
@end
