//
//  ViewController.m
//  SWCaptcha
//
//  Created by Swagatika Rath on 10/17/16.
//  Copyright © 2016 Swagatika Rath. All rights reserved.
//

#import "ViewController.h"
#import "Record.h"
#import "HistoryPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mManagedObjectContext;


-(void)viewDidAppear:(BOOL)animated
{
    [self.view setUserInteractionEnabled:YES];
    [self CaptchaCode_generate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *loApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.mManagedObjectContext = loApp.managedObjectContext;
}

-(void)CaptchaCode_generate
{
    
    _enterCodeField.text=@"";
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [_alertLabel setAlpha:0.0];
    [UIView commitAnimations];
    
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY";
    static NSString *digits = @"0123456789";
    NSMutableString *Captchacode = [NSMutableString stringWithCapacity:8];
    for (NSUInteger i = 0; i < 2; i++)
    {
        uint32_t random;
        
        // Append 2 random letters:
        random = arc4random_uniform((uint32_t)[letters length]);
        [Captchacode appendFormat:@"%C", [letters characterAtIndex:random]];
        random = arc4random_uniform((uint32_t)[letters length]);
        [Captchacode appendFormat:@"%C", [letters characterAtIndex:random]];
        
        // Append 2 random digits:
        random = arc4random_uniform((uint32_t)[digits length]);
        [Captchacode appendFormat:@"%C", [digits characterAtIndex:random]];
        random = arc4random_uniform((uint32_t)[digits length]);
        [Captchacode appendFormat:@"%C", [digits characterAtIndex:random]];
    }
    
    [_codetextField setText:Captchacode];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signIn:(id)sender {
    
   
    NSString *entryStr;
    
    if ([_enterCodeField.text compare:@"(null)"] == NSOrderedSame || [_enterCodeField.text compare:@""] == NSOrderedSame)
    {
        [_alertLabel setTextColor:[UIColor colorWithRed:231.0/255 green:93.0/255 blue:66.0/255 alpha:1.0f]];
        [_alertLabel setText:@"Please enter the code"];
       // [self performSelector:@selector(Hide_Alertmsg) withObject:nil afterDelay:2.0];
    }
    else
    {
        if ([_enterCodeField.text compare:_codetextField.text] == NSOrderedSame)
        {
            [self.view setUserInteractionEnabled:NO];
            [_alertLabel setTextColor:[UIColor colorWithRed:20.0/255 green:188.0/255 blue:140.0/255 alpha:1.0f]];
            [_alertLabel setText:@"Login successfully"];
            entryStr = [NSString stringWithFormat:@"%@_1",_codetextField.text];
            [self performSelector:@selector(Navigate_Page) withObject:nil afterDelay:1.4];
        }
        else
        {
            [_alertLabel setTextColor:[UIColor colorWithRed:231.0/255 green:93.0/255 blue:66.0/255 alpha:1.0f]];
            [_alertLabel setText:@"Incorrect code"];
            entryStr = [NSString stringWithFormat:@"%@_0",_codetextField.text];
            [self performSelector:@selector(CaptchaCode_generate) withObject:nil afterDelay:1.4];
        }
        
        // Save the Date in core data server..............
        
        Record *newentry = (Record*)[NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.mManagedObjectContext];
        newentry.code = entryStr;
        NSError *error;
        if ([self.mManagedObjectContext save:&error])
        {
            NSLog(@"save successfully");
        }
        else
        {
            NSLog(@"fail to save");
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [_alertLabel setAlpha:1.0];
    [UIView commitAnimations];
}

-(void)Hide_Alertmsg
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [_alertLabel setAlpha:0.0];
    [UIView commitAnimations];
}
-(void)Navigate_Page
{
    _enterCodeField.text=@"";
    _alertLabel.alpha=0.0;
    [_alertLabel setText:@""];
    _codetextField.text=@"";
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HistoryPageViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"HistoryPageViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
