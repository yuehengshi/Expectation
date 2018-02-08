//
//  SPClockView.h
//  ClockWorld
//
//  Created by Nguyen Huu Hoang on 3/30/15.
//  Copyright (c) 2015 Phoenix NH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDigitalClock : UILabel
@property (strong,nonatomic) NSTimeZone *timeZone;
@end

@interface SPClockView : UIView

@property (strong,nonatomic) NSTimeZone *timeZone;
-(void)if_night:(BOOL)isDay;

@end
