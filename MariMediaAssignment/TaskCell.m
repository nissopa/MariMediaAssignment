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
    taskTitleLabel.text = task.taskTitle;
    taskDescriptionLabel.text = task.taskDescription;
    taskDateLabel.text = [task.taskDate inString];
    categoryLabel.backgroundColor = [task.taskCategory.categoryColor stringRGB];
    categoryLabel.text = task.taskCategory.categoryName;
}

@end
