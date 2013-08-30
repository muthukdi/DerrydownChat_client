//
//  ResetRequest.h
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-23.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol ResetRequestDelegate
@optional
- (void) resetVariables;
@end

@interface ResetRequest : NSObject <NSURLConnectionDataDelegate>
{
    id _delegate;
}

@property (strong, nonatomic) NSMutableData *responseData;

- (id) initWithDelegate:(id)delegate;
- (void) sendRequest;

@end
