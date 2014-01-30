//
//  TasksCategory.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tasks;

@interface TasksCategory : NSManagedObject

@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSString * categoryColor;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface TasksCategory (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Tasks *)value;
- (void)removeTasksObject:(Tasks *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
