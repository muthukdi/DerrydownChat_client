//
//  GetMessageRequest.h
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-21.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol GetMessageRequestDelegate
@optional
- (void) messageHasBeenRetrieved:(NSString *)theirMessage;
@end

@interface GetMessageRequest : NSObject <NSURLConnectionDataDelegate>
{
    id _delegate;
}

@property (strong, nonatomic) NSMutableData *responseData;

- (id) initWithDelegate:(id)delegate;
- (void) sendRequest;

@end
