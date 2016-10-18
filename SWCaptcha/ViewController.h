//
//  ViewController.h
//  SWCaptcha
//
//  Created by Swagatika Rath on 10/17/16.
//  Copyright © 2016 Swagatika Rath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codetextField;
@property (weak, nonatomic) IBOutlet UITextField *enterCodeField;

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property(nonatomic ,strong)NSManagedObjectContext *mManagedObjectContext;

- (IBAction)signIn:(id)sender;
@end

