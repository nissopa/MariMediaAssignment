//
//  TaskCell.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "TaskCell.h"
#import "NSDate+Calculation.h"
#import "TasksCategory.h"
#import "NSString+Dates.h"

@implementation TaskCell

- (void)loadTaskCell:(Tasks *)task {
    currentTask = task;
    taskTitleLabel.text = task.taskTitle;
    taskDateLabel.text = [task.taskDate inString];
    doneButton.selected = task.isDone.boolValue;
}

- (IBAction)taskSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_delegate taskCell:self didSelected:currentTask];
}
@end
