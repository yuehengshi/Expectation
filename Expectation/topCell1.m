//
//  topCell1.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import "topCell1.h"
#import "Masonry.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CONTENTVIEW_WIDTH self.contentView.bounds.size.width
#define CONTENTVIEW_HEIGHT self.contentView.bounds.size.height
@implementation topCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    [_status mas_makeConstraints:^(MASConstraintMaker *make)
     {

         make.centerX.equalTo(self.contentView.mas_centerX);
         make.top.equalTo(self.contentView.mas_top).offset(SCREEN_HEIGHT/14);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, CONTENTVIEW_HEIGHT*0.135));
     }];
    [_time mas_makeConstraints:^(MASConstraintMaker *make)
     {

          make.centerX.equalTo(self.contentView.mas_centerX);
         make.top.equalTo(_status.mas_bottom).offset(0);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, CONTENTVIEW_HEIGHT*0.165));
     }];

    [_pic mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.contentView.mas_centerX);
         make.top.equalTo(_time.mas_bottom).offset(3);
         make.size.mas_equalTo(CGSizeMake(CONTENTVIEW_WIDTH*0.125, CONTENTVIEW_HEIGHT*0.125));
     }];

    [_title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.contentView.mas_centerX);
         make.top.equalTo(_pic.mas_bottom).offset(5);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, CONTENTVIEW_HEIGHT*0.08));

     }];
    [_left mas_makeConstraints:^(MASConstraintMaker *make)
     {
        
         make.right.equalTo(_pic.mas_left).offset(8);
         make.top.equalTo(_time.mas_bottom).offset(11);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.31, CONTENTVIEW_HEIGHT*0.08));
     }];
    [_right mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_pic.mas_right).offset(8);
         make.top.equalTo(_time.mas_bottom).offset(11);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.31, CONTENTVIEW_HEIGHT*0.08));
     }];
    [_status sizeToFit];
    [_time sizeToFit];
    [_title sizeToFit];
    [_left sizeToFit];
    [_right sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
