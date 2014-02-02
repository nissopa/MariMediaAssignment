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
    __weak IBOutlet UIButton *rememberMeButton;
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
    
    // Initializing the DataBase
    [[DataBaseManager instance] initializeDB:^(NSManagedObjectContext *context) {
        if (context) {
            
        }
    }];
    
    
    // Listening to the keyboard state
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    // Checks if need to present registration page or login page
    if (![DataBaseManager instance].userName) {
        loginButton.enabled = NO;
        retypeTF.hidden = NO;
        signInButton.hidden = NO;
    } else if ([DataBaseManager instance].userName && [DataBaseManager instance].remeberMe) {
        userName.text = [DataBaseManager instance].userName;
        passwordTF.text = [DataBaseManager instance].password;
        loginButton.enabled = YES;
        signInButton.enabled = NO;
        rememberMeButton.selected = YES;
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


// Checkbox for automatic fill of the credentials
- (IBAction)rememberMePressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    [DataBaseManager instance].remeberMe = sender.selected;
}


// Validation of the credentials before moving to the tasks page (in case that the user already enterd the app before)
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


// Validation of the values and storing it for next time
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


// Moving up all the UI elements for making space to the keyboard
- (void)keyboardDidShow:(NSNotification *)notification {
    [self moveUIToYPos:-70];
}


// Moving down all the UI elements when the keyboard dissmissed
- (void)keyboardDidHide:(NSNotification *)notification {
    [self moveUIToYPos:70];
}

// Animating the UI elements
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


// Dissmissing the keyboard if touching the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
