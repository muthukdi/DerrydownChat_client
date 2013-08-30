//
//  AppDelegate.m
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-20.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Did finish launching");
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"Will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"Did enter background");
    //ResetRequest *requestObject = [[ResetRequest alloc] initWithDelegate:self.window.rootViewController];
    //[requestObject sendRequest];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"Did enter foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Did become active");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"Will terminate");
}

@end
