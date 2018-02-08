//
//  GuideVC.h
//  Expectation
//
//  Created by Syh on 16/8/31.
//  Copyright © 2016年 5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GuideVC : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@end
