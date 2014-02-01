//
//  TaskCell.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"
@class TaskCell;
@protocol TaskCellDelegate <NSObject>

- (void)taskCell:(TaskCell *)taskCell didSelected:(Tasks *)task;

@end

@interface TaskCell : UITableViewCell {
    __weak IBOutlet UILabel *taskTitleLabel;
    __weak IBOutlet UILabel *taskDateLabel;
    __weak IBOutlet UIButton *doneButton;
    Tasks *currentTask;
}

@property (nonatomic, weak) id<TaskCellDelegate> delegate;

- (void)loadTaskCell:(Tasks *)task;
- (IBAction)taskSelected:(UIButton *)sender;
@end
