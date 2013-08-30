//
//  AppDelegate.h
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-20.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResetRequest.h"

NSString *username;
NSString *message;
BOOL turn;
BOOL onlineStatus;
BOOL usersReady;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
