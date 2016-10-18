//
//  HistoryPageViewController.m
//  SWCaptcha
//
//  Created by Swagatika Rath on 10/17/16.
//  Copyright © 2016 Swagatika Rath. All rights reserved.
//

#import "HistoryPageViewController.h"
#import "AppDelegate.h"
#import "Record.h"

@interface HistoryPageViewController ()

@end

@implementation HistoryPageViewController

@synthesize CodeHistory_Arr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.4];
    _tableView.transform = CGAffineTransformMakeScale(1.0,1.0);
    [UIView commitAnimations];
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.CodeHistory_Arr = [app getAllCaptchaCode:@"Record"];
    for (int i = 0; i < [self.CodeHistory_Arr count]; i++)
    {
        Record *lorecord = [self.CodeHistory_Arr objectAtIndex:i];
        NSLog(@"%@",lorecord.code);
    }
   
}

#pragma mark - UITableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.CodeHistory_Arr count] > 10)
    {
        return 10;
    }
    else
    {
        return [self.CodeHistory_Arr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Record *lorecord;
    if ([self.CodeHistory_Arr count] > 10)
    {
        lorecord = [self.CodeHistory_Arr objectAtIndex:([self.CodeHistory_Arr count]-(10-indexPath.row))];
    }
    else
    {
        lorecord = [self.CodeHistory_Arr objectAtIndex:indexPath.row];
    }
    
    NSString *entryStr = lorecord.code;
    if ([[[entryStr componentsSeparatedByString:@"_"] objectAtIndex:1] intValue] == 0)
    {
        [cell.textLabel setTextColor:[UIColor redColor]];
    }
    else
    {
        [cell.textLabel setTextColor:[UIColor colorWithRed:20.0/255 green:188.0/255 blue:140.0/255 alpha:1.0f]];
    }
    cell.textLabel.text = [[entryStr componentsSeparatedByString:@"_"] objectAtIndex:0];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"You clicked %ld index",(long)indexPath.row);
}

@end
