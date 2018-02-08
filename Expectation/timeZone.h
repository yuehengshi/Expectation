//
//  timeZone.h
//  Expectation
//
//  Created by Syh on 16/9/20.
//  Copyright © 2016年 5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timeZone : UITableViewController<UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)   NSArray *country ;
@property (strong, nonatomic)    NSDictionary *relation;
@property (strong, nonatomic)    NSDictionary *city_and_timezone;
@end
