//
//  GuideVC.m
//  Expectation
//
//  Created by Syh on 16/8/31.
//  Copyright © 2016年 5. All rights reserved.
//

#import "GuideVC.h"
#import "MainTabBarController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation GuideVC
int numOfPages = 4;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",SCREEN_WIDTH);
    NSLog(@"%f",SCREEN_HEIGHT);
    _scrollView=[[UIScrollView alloc]init];
    
    _scrollView.delegate = self;
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * numOfPages, SCREEN_HEIGHT);
    
    _scrollView.pagingEnabled = true;
    
    for(int i=0;i<numOfPages;i++)
    {
        _imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i]];
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [_scrollView addSubview:_imgView];
    }
    _scrollView.contentOffset = CGPointZero ;
    [self.view addSubview:_scrollView];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int third = (numOfPages - 2) * [UIScreen mainScreen].bounds.size.width;
    if (scrollView.contentOffset.x > third)
    {
        
        MainTabBarController *vc = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];

        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];

        [self presentViewController:vc animated:YES completion:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
