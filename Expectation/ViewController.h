//
//  ViewController.h
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface ViewController : UIViewController
{
sqlite3 *dataBase;
NSString *databasePath;
}
@end

