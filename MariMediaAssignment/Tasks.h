//
//  Tasks.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TasksCategory;

@interface Tasks : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSString * taskTitle;
@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSDate * taskDate;
@property (nonatomic, retain) NSNumber * taskPriority;
@property (nonatomic, retain) TasksCategory *taskCategory;

@end
