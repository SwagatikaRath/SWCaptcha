//
//  HistoryPageViewController.h
//  SWCaptcha
//
//  Created by Swagatika Rath on 10/17/16.
//  Copyright © 2016 Swagatika Rath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryPageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *CodeHistory_Arr;

@end
