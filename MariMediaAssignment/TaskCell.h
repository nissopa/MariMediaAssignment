//
//  TaskCell.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

@interface TaskCell : UITableViewCell {
    __weak IBOutlet UILabel *taskTitleLabel;
    __weak IBOutlet UILabel *taskDescriptionLabel;
    __weak IBOutlet UILabel *taskDateLabel;
    __weak IBOutlet UILabel *categoryLabel;
}


- (void)loadTaskCell:(Tasks *)task;
@end
