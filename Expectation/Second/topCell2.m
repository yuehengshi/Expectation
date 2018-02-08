//
//  topCell2.m
//  Expectation
//
//  Created by Syh on 16/9/19.
//  Copyright © 2016年 5. All rights reserved.
//

#import "topCell2.h"
#import "Masonry.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CONTENTVIEW_WIDTH self.contentView.bounds.size.width
#define CONTENTVIEW_HEIGHT self.contentView.bounds.size.height
@implementation topCell2

- (void)awakeFromNib {
    [super awakeFromNib];
//    _status = [[UILabel alloc]init];
//    _status.textColor = [ UIColor whiteColor];
//    _status.numberOfLines = 1;
//    [_status sizeToFit];
//    _status.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_status];
//    
//    _time = [[UILabel alloc]init];
//    _time.textColor = [ UIColor whiteColor];
//    _time.numberOfLines = 1;
//    [_time sizeToFit];
//    _time.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_time];
//
//    _pic = [[UIImageView alloc]init];
//    [self.contentView addSubview:_pic];
//
//    _left = [[UILabel alloc]init];
//    _left.textColor = [ UIColor whiteColor];
//    _left.text=@"————————";
//    _left.numberOfLines = 1;
//    [_left sizeToFit];
//    _left.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_left];
//
//    _right = [[UILabel alloc]init];
//    _right.textColor = [ UIColor whiteColor];
//    _right.text=@"————————";
//    _right.numberOfLines = 1;
//    [_right sizeToFit];
//    _right.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_right];
//
//    _title = [[UILabel alloc]init];
//    _title.textColor = [ UIColor whiteColor];
//    _title.numberOfLines = 1;
//    [_title sizeToFit];
//    _title.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_title];
//
//    _day = [[UILabel alloc]init];
//    _day.textColor = [ UIColor whiteColor];
//    _day.text=@"天";
//    _day.numberOfLines = 1;
//    [_day sizeToFit];
//    _day.textAlignment =UITextAlignmentCenter;
//    [self.contentView addSubview:_day];

    
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
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, CONTENTVIEW_HEIGHT*0.20));
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
    [_day mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self.contentView.mas_right).offset(0);
         make.top.equalTo(_status.mas_top).offset(87);
         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.092, CONTENTVIEW_HEIGHT*0.092));
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
