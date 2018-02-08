//
//  Download.h
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemModel.h"
#import "NetTools.h"
#import "dayModel.h"
#import "worldModel.h"
@interface Download : UIViewController<UITextFieldDelegate> 
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)download:(id)sender;
@property (nonatomic,strong) itemModel *model;
@property (nonatomic,strong) NSMutableArray *arraM;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) dayModel *model1;
@property (nonatomic,strong) NSMutableArray *arraM1;
@property (nonatomic,strong) NSArray *array1;
@property (nonatomic,strong) NetTools *net;
@property (nonatomic,strong) worldModel *model2;
@property (nonatomic,strong) NSMutableArray *arraM2;
@property (nonatomic,strong) NSArray *array2;
@property (strong, nonatomic)NSString *num;
@end
