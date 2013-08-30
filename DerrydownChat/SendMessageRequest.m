//
//  SendMessageRequest.m
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-21.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import "SendMessageRequest.h"

@implementation SendMessageRequest

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
    NSString *modified = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *fullURL = [NSString stringWithFormat:@"http://192.168.1.3/dilip/send.php?usernameField=%@&messageField=%@", username, modified];
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
    
    NSString *result = (NSString *)[res objectForKey:@"result"];
    if ([result isEqualToString:@"reset"])
    {
        [_delegate resetVariables];
    }
    else
    {
        [_delegate messageHasBeenSent];
    }
}

@end
