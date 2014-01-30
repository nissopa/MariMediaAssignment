//
//  AddTaskViewController.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddTaskViewController;
@protocol AddTaskViewControllerDelegate <NSObject>

- (void)addTask:(AddTaskViewController *)taskVC addTaskParams:(NSDictionary *)taskParams;

@end
@interface AddTaskViewController : UIViewController

@property (nonatomic, weak) id<AddTaskViewControllerDelegate> delegate;
@end
