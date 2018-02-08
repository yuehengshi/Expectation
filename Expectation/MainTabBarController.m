//
//  MainTabBarController.m
//  Expectation
//
//  Created by Syh on 16/8/27.
//  Copyright © 2016年 5. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "NavigationController.h"

#import "GuideVC.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self setUpAllChildViewController];
    NSLog(@"\n%@",[self printSandboxPath]);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpAllChildViewController{

    FirstViewController *firstVC = [[FirstViewController alloc]init];
    [self setUpOneChildViewController:firstVC image:[UIImage imageNamed:@"1"] title:@"HOUR"];
    
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self setUpOneChildViewController:secondVC image:[UIImage imageNamed:@"n"] title:@"DAY"];
    
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    [self setUpOneChildViewController:thirdVC image:[UIImage imageNamed:@"world"] title:@"WORLD"];
  
}

-(NSString*)printSandboxPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    return documentsDirectory;
    
}

 //  添加一个子控制器的方法

- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    
    NavigationController *navC = [[NavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
 //   [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"1"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    

    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
navC.navigationBar.shadowImage=[UIImage new];


 //navigation标题颜色
    UIColor * color1 = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color1 forKey:UITextAttributeTextColor];
    navC.navigationBar.titleTextAttributes = dict;
    [self addChildViewController:navC];
    
  
}




@end
