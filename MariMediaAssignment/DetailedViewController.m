//
//  DetailedViewController.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 2/1/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "DetailedViewController.h"
#import "NSString+Dates.h"
#import "TasksCategory.h"

@interface DetailedViewController () {
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextView *descriptionTextview;
    __weak IBOutlet UILabel *categoryLabel;
    __weak IBOutlet UILabel *titleLabel;
}
- (IBAction)backPressed:(UIButton *)sender;
@end

@implementation DetailedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dateLabel.text = [_task.taskDate inString];
    titleLabel.text = _task.taskTitle;
    descriptionTextview.text = _task.taskDescription;
    categoryLabel.text = _task.taskCategory.categoryName;
    categoryLabel.backgroundColor = [_task.taskCategory.categoryColor stringRGB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
