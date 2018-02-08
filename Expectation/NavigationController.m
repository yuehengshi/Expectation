//
//  NavigationController.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import "NavigationController.h"


@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
//
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
                /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
            }
        [super pushViewController:viewController animated:animated];
}


@end
