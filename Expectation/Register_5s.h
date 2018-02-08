//
//  Register_5s.h
//  Expectation
//
//  Created by Syh on 16/9/25.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetTools.h"
@interface Register_5s : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)register:(id)sender;

@property (nonatomic,strong) NSMutableArray *arraM;
@property (nonatomic,strong) NetTools *net;
@property (strong, nonatomic)NSString *num;
@end
