//
//  worldModel.m
//  Expectation
//
//  Created by Syh on 16/9/20.
//  Copyright © 2016年 5. All rights reserved.
//

#import "worldModel.h"

@implementation worldModel
+(instancetype)AccountModelWithDict:(NSDictionary*)dict
{
    if (dict == nil) {
        return nil;
    }
    
    worldModel *model = [[worldModel alloc]init];
    if (model != nil) {
        model.id = [dict objectForKey:@"id"];
        model.timezone = [dict objectForKey:@"timezone"];
        model.country = [dict objectForKey:@"country"];
    }
    return model;
}
@end
