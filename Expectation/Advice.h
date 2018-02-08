//
//  Advice.h
//  Expectation
//
//  Created by Syh on 16/9/14.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetTools.h"
@interface Advice : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic)NSString *num;
- (IBAction)submit:(id)sender;
@end
