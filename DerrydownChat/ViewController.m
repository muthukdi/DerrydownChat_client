//
//  ViewController.m
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-20.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize messageField = _messageField;
@synthesize messageLabel = _messageLabel;
@synthesize sendButton = _sendButton;
@synthesize connectButton = _connectButton;
@synthesize yourStatus = _yourStatus;
@synthesize theirStatus = _theirStatus;

- (void)viewDidLoad
{
    [super viewDidLoad];
	_sendButton.hidden = YES;
}

- (IBAction)sendPressed:(id)sender
{
    NSLog(@"Sending...");
    [_messageField resignFirstResponder];
    message = _messageField.text;
    _messageLabel.text = message;
    SendMessageRequest *requestObject = [[SendMessageRequest alloc] initWithDelegate:self];
    [requestObject sendRequest];
}

- (IBAction)connectPressed:(id)sender
{
    NSLog(@"Connecting...");
    [_messageField resignFirstResponder];
    UsernameRequest *requestObject = [[UsernameRequest alloc] initWithName:self.messageField.text delegate:self];
    [requestObject sendRequest];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

- (void) determineStatusOfotherUser
{
    NSLog(@"Determining status of other user...");
    onlineStatus = 1;
    _yourStatus.text = @"Online";
    _yourStatus.textColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    _connectButton.hidden = YES;
    StatusRequest *requestObject = [[StatusRequest alloc] initWithDelegate:self];
    [requestObject sendRequest];
}

- (void) respondToStatusRequest:(BOOL)status
{
    if (status)
    {
        NSLog(@"Users are both ready to start messaging!");
        usersReady = YES;
        _theirStatus.text = @"Online";
        _theirStatus.textColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        _sendButton.hidden = !turn;
        if (!turn)
        {
            GetMessageRequest *requestObject = [[GetMessageRequest alloc] initWithDelegate:self];
            [requestObject sendRequest];
        }
    }
    else
    {
        StatusRequest *requestObject = [[StatusRequest alloc] initWithDelegate:self];
        [requestObject sendRequest];
    }
}

- (void) messageHasBeenSent
{
    NSLog(@"Your message has been sent!");
    turn = 0;
    _sendButton.hidden = !turn;
    // Very important to do this because GetMessageRequest will be sent
    // by both clients so they might clash
    sleep(1);
    GetMessageRequest *requestObject = [[GetMessageRequest alloc] initWithDelegate:self];
    [requestObject sendRequest];
}

- (void) messageHasBeenRetrieved:(NSString *)theirMessage
{
    if ([theirMessage isEqualToString:@"1"])
    {
        NSLog(@"The other user hasn't replied back yet...");
        GetMessageRequest *requestObject = [[GetMessageRequest alloc] initWithDelegate:self];
        [requestObject sendRequest];
    }
    else
    {
        NSLog(@"Received their message!");
        turn = 1;
        _sendButton.hidden = !turn;
        _messageLabel.text = theirMessage;
    }
}

@end
