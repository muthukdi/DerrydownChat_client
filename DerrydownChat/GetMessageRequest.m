//
//  GetMessageRequest.m
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-21.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import "GetMessageRequest.h"

@implementation GetMessageRequest

@synthesize responseData = _responseData;

- (id) initWithDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
    }
    return (self);
}

- (void) sendRequest
{
    self.responseData = [NSMutableData data];
    NSString *fullURL = [NSString stringWithFormat:@"http://192.168.1.3/dilip/get.php?usernameField=%@", username];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        NSLog(@"received authentication challenge");
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"xampp"
                                                                    password:@"december"
                                                                 persistence:NSURLCredentialPersistenceForSession];
        NSLog(@"credential created");
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        NSLog(@"responded to authentication challenge");
    }
    else {
        NSLog(@"previous authentication failure");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"%@", message);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&myError];

    NSString *theirMessage = (NSString *)[res objectForKey:@"message"];
    NSLog(@"The other user's message is %@", theirMessage);
    if ([theirMessage isEqualToString:@"reset"])
    {
        [_delegate resetVariables];
    }
    else
    {
        [_delegate messageHasBeenRetrieved:theirMessage];
    }
}

@end
