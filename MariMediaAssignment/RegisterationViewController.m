//
//  RegisterationViewController.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "RegisterationViewController.h"
#import "NSString+Dates.h"
#import "UIView+Position.h"

@interface RegisterationViewController () {
    __weak IBOutlet UIButton *start;
    __weak IBOutlet UITextField *userName;
    __weak IBOutlet UITextField *passwordTF;
    __weak IBOutlet UITextField *retypeTF;
}

- (IBAction)signInPressed:(UIButton *)sender;
- (IBAction)loginPressed:(UIButton *)sender;
- (IBAction)rememberMePressed:(UIButton *)sender;
@end

@implementation RegisterationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[DataBaseManager instance] initializeDB:^(NSManagedObjectContext *context) {
        if (context) {
            start.hidden = NO;
        }
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if (![DataBaseManager instance].userName) {
        loginButton.enabled = NO;
        retypeTF.hidden = NO;
        signInButton.hidden = NO;
    } else if ([DataBaseManager instance].userName && [DataBaseManager instance].remeberMe) {
        userName.text = [DataBaseManager instance].userName;
        passwordTF.text = [DataBaseManager instance].password;
        loginButton.enabled = YES;
        signInButton.enabled = NO;
    } else if ([DataBaseManager instance].userName) {
        loginButton.enabled = YES;
        signInButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)credentialsCorrect:(UIButton *)sender {
    
}

- (IBAction)rememberMePressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    [DataBaseManager instance].remeberMe = sender.selected;
}

- (IBAction)loginPressed:(UIButton *)sender {
    if ([userName.text isEqualToString:[DataBaseManager instance].userName] && [passwordTF.text isEqualToString:[DataBaseManager instance].password]) {
        [self performSegueWithIdentifier:@"EnterTaskManager" sender:nil];
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Value not valid"
                                                     message:@"One of the fields not correct, please try again"
                                                    delegate:nil
                                           cancelButtonTitle:@"Try again"
                                           otherButtonTitles:nil, nil];
        [av show];
    }
}

- (IBAction)signInPressed:(UIButton *)sender {
    NSString *messageAlert = nil;
    if ([userName.text isEmailValid] && [passwordTF.text isEqualToString:retypeTF.text]) {
        [DataBaseManager instance].userName = userName.text;
        [DataBaseManager instance].password = passwordTF.text;
        [self performSegueWithIdentifier:@"EnterTaskManager" sender:nil];
        return;
    } else if (![userName.text isEmailValid]) {
        messageAlert = @"Email address not valid, please check and try again";
    } else if (![passwordTF.text isEqualToString:retypeTF.text]) {
        messageAlert = @"Password not match, please try again";
    }
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Value not valid"
                                                 message:messageAlert
                                                delegate:nil
                                       cancelButtonTitle:@"Try Again"
                                       otherButtonTitles:nil, nil];
    [av show];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    [self moveUIToYPos:-70];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [self moveUIToYPos:70];
}

- (void)moveUIToYPos:(CGFloat)YPos {
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         for (UIView *v in self.view.subviews) {
                             v.yPos = v.frame.origin.y + YPos;
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
