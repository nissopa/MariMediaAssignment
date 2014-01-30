//
//  AddTaskViewController.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "AddTaskViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Position.h"

@interface AddTaskViewController () <UITextFieldDelegate, UITextViewDelegate>{
    __weak IBOutlet UIView *taskContainer;
    __weak IBOutlet UITextField *titleTF;
    __weak IBOutlet UITextView *descriptionTV;
    __weak IBOutlet UITextField *dateTF;
    NSMutableDictionary *taskParams;
}
- (IBAction)addTask:(UIButton *)sender;
@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)addTask:(UIButton *)sender {
    if ([self isTaskValid]) {
        [UIView animateWithDuration:0.25 delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             taskContainer.yPos = -306;
                         } completion:^(BOOL finished) {
                             [_delegate addTask:self addTaskParams:taskParams];
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                         }];
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Empty Value"
                                                     message:@"Please fill all the fields"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil, nil];
        [av show];
    }
}

- (BOOL)isTaskValid {
    for (UITextField *tf in taskContainer.subviews) {
        if ([tf isKindOfClass:[UITextField class]] && [tf.text isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    taskContainer.layer.masksToBounds = NO;
    taskContainer.layer.cornerRadius = 8; // if you like rounded corners
    taskContainer.layer.shadowOffset = CGSizeMake(-15, 20);
    taskContainer.layer.shadowRadius = 5;
    taskContainer.layer.shadowOpacity = 0.5;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         taskContainer.yPos = 30;
                     } completion:nil];
    [titleTF becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate methods

#pragma mark UITextViewDelegate methods


@end
