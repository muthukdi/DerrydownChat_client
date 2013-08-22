//
//  UsernameRequest.h
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-21.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol UsernameRequestDelegate
@optional
- (void) determineStatusOfotherUser;
@end

@interface UsernameRequest : NSObject <NSURLConnectionDataDelegate>
{
    NSString *_username;
    id _delegate;
}

@property (strong, nonatomic) NSMutableData *responseData;

- (id) initWithName:(NSString *)name delegate:(id)delegate;
- (void) sendRequest;

@end
