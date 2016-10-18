//
//  AppDelegate.h
//  SWCaptcha
//
//  Created by Swagatika Rath on 10/17/16.
//  Copyright © 2016 Swagatika Rath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;
-(NSArray*)getAllCaptchaCode:(NSString*)Code;

@end

