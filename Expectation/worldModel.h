//
//  worldModel.h
//  Expectation
//
//  Created by Syh on 16/9/20.
//  Copyright © 2016年 5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface worldModel : NSObject
@property (strong, nonatomic)NSString *id;
@property (strong, nonatomic)NSString *timezone;
@property (strong, nonatomic)NSString *country;

+(instancetype)AccountModelWithDict:(NSDictionary*)dict;
@end
