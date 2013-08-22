//
//  ViewController.h
//  DerrydownChat
//
//  Created by Dilip Muthukrishnan on 13-08-20.
//  Copyright (c) 2013 Dilip Muthukrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsernameRequest.h"
#import "StatusRequest.h"
#import "SendMessageRequest.h"
#import "GetMessageRequest.h"

@interface ViewController : UIViewController <UsernameRequestDelegate,
                                                StatusRequestDelegate,
                                                SendMessageRequestDelegate,
                                                GetMessageRequestDelegate>


@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UILabel *yourStatus;
@property (weak, nonatomic) IBOutlet UILabel *theirStatus;


- (IBAction)sendPressed:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)connectPressed:(id)sender;

@end
