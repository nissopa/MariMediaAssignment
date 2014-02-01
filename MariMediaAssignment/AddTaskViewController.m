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
#import "DataBaseManager.h"
#import "NSString+Dates.h"
#import "TasksCategory.h"

@interface AddTaskViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    __weak IBOutlet UIView *taskContainer;
    __weak IBOutlet UITextField *titleTF;
    __weak IBOutlet UITextView *descriptionTV;
    __weak IBOutlet UITextField *dateTF;
    __weak IBOutlet UITextField *categoryTF;
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UIPickerView *categoryPicker;
    __weak IBOutlet UIView *accessoryView;
    NSMutableDictionary *taskParams;
    NSArray *categoryList;
    BOOL isCategoryColorSelected;
}
- (IBAction)addTask:(UIButton *)sender;
- (IBAction)categoryColorPressed:(UIButton *)sender;
- (IBAction)datePickerChanged:(UIDatePicker *)sender;
- (IBAction)addCategory:(UIButton *)sender;
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

- (IBAction)categoryColorPressed:(UIButton *)sender {
    isCategoryColorSelected = YES;
    taskParams[TaskCategoryColor] = [DataBaseManager instance].categoryColors[sender.tag];
    categoryTF.backgroundColor = [[DataBaseManager instance].categoryColors[sender.tag] stringRGB];
    categoryTF.textColor = [UIColor whiteColor];
}

- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    dateTF.text = [sender.date inString];
}

- (IBAction)addCategory:(UIButton *)sender {
    categoryTF.text = @"";
    categoryTF.inputView = nil;
    datePicker.hidden = YES;
    [categoryTF reloadInputViews];
    accessoryView.hidden = YES;
}

- (BOOL)isTaskValid {
    BOOL valid = YES;
    for (UITextField *tf in taskContainer.subviews) {
        if ([tf isKindOfClass:[UITextField class]]) {
            valid &= ![tf.text isEqualToString:@""];
            if ([tf isEqual:titleTF]) {
                taskParams[TaskTitleKey] = tf.text;
            } else if ([tf isEqual:dateTF]) {
                taskParams[TaskDateKey] = tf.text;
            } else {
                taskParams[TaskCategoryKey] = tf.text;
            }
        } else if ([tf isKindOfClass:[UITextView class]]) {
            taskParams[TaskDescriptionKey] = tf.text;
        }
    }
    return isCategoryColorSelected && valid;
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
    taskParams = [NSMutableDictionary new];
    dateTF.inputView = datePicker;
    categoryList = [[DataBaseManager instance] categoriesListForPicker];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:dateTF]) {
        datePicker.hidden = NO;
        categoryPicker.hidden = YES;
        textField.text = [datePicker.date inString];
    } else if ([textField isEqual:categoryTF] && categoryList.count) {
        categoryTF.inputView = categoryPicker;
        categoryTF.inputAccessoryView = accessoryView;
        categoryPicker.hidden = NO;
        datePicker.hidden = YES;
        accessoryView.hidden = NO;
        textField.textColor = [UIColor whiteColor];
        textField.text = categoryList[0];
        TasksCategory *category = [[DataBaseManager instance] categoryByName:categoryTF.text];
        categoryTF.backgroundColor = [category.categoryColor stringRGB];
        taskParams[TaskCategoryColor] = category.categoryColor;
        isCategoryColorSelected = YES;
    }
    return YES;
}

#pragma mark UIPickerViewDelegate methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return categoryList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return categoryList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    categoryTF.text = categoryList[row];
    TasksCategory *category = [[DataBaseManager instance] categoryByName:categoryTF.text];
    categoryTF.backgroundColor = [category.categoryColor stringRGB];
}

#pragma mark UITextViewDelegate methods
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    taskParams[TaskDescriptionKey] = textView.text;
    return YES;
}

@end
