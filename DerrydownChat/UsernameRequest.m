//
//  UsernameRequest.m
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-21.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import "UsernameRequest.h"

@implementation UsernameRequest

@synthesize responseData = _responseData;

- (id) initWithName:(NSString *)name delegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        _username = name;
        _delegate = delegate;
    }
    return (self);
}

- (void) sendRequest
{
    self.responseData = [NSMutableData data];
    NSString *fullURL = [NSString stringWithFormat:@"http://derrydown.tk/dilip/username.php?usernameField=%@", _username];
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
    
    // Analyze the response
    NSString *status = (NSString *)[res objectForKey:@"status"];
    NSLog(@"Status of this user is %@", status);
    if ([status isEqualToString:@"0"])
    {
        username = _username;
        NSLog(@"You are online!");
        [_delegate determineStatusOfotherUser];
    }
    else
    {
        NSLog(@"Sorry, you can't use that name.");
    }
}


@end
