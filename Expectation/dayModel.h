//
//  dayModel.h
//  Expectation
//
//  Created by Syh on 16/9/19.
//  Copyright © 2016年 5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dayModel : NSObject
@property (strong, nonatomic)NSString *id;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *category;
@property (strong, nonatomic)NSString *time;
@property (strong, nonatomic)NSString *iftop;
@property (strong, nonatomic)NSString *ifpass;
@property (strong, nonatomic)NSString *backimage;
@property (strong, nonatomic)NSString *ifremind;
@property (strong, nonatomic)NSString *music;
@property (strong, nonatomic)NSString *interval;
+(instancetype)AccountModelWithDict:(NSDictionary*)dict
;
@end
