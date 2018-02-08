//
//  bottomCell1.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import "bottomCell1.h"
#import "Masonry.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation bottomCell1

- (void)awakeFromNib {
    [super awakeFromNib];

//    [_pic mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.equalTo(self.contentView.mas_left).offset(4);
//       //  make.right.equalTo(self.contentView.mas_right).offset(0);
//         make.top.equalTo(self.contentView.mas_top).offset(self.contentView.bounds.size.height/12);
//         make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.122,self.contentView.bounds.size.height*0.59));
//     }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
