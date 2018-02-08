//
//  dayModel.m
//  Expectation
//
//  Created by Syh on 16/9/19.
//  Copyright © 2016年 5. All rights reserved.
//

#import "dayModel.h"

@implementation dayModel
+(instancetype)AccountModelWithDict:(NSDictionary*)dict
{
    if (dict == nil) {
        return nil;
    }
    
    dayModel *model = [[dayModel alloc]init];
    if (model != nil) {
        model.id = [dict objectForKey:@"id"];
        model.title = [dict objectForKey:@"title"];
        model.category = [dict objectForKey:@"category"];
        model.time = [dict objectForKey:@"time"];
        model.iftop = [dict objectForKey:@"iftop"];
        model.ifpass = [dict objectForKey:@"ifpass"];
        model.backimage = [dict objectForKey:@"backimage"];
        model.ifremind = [dict objectForKey:@"ifremind"];
        model.music = [dict objectForKey:@"music"];
        model.interval = [dict objectForKey:@"interval"];
    }
    return model;
}
@end
