//
//  DataBaseManager.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tasks.h"
#import "TasksCategory.h"
#import <CoreData/CoreData.h>

static NSString *TaskTitleKey = @"TaskTitleKey";
static NSString *TaskDescriptionKey = @"TaskDescriptionKey";
static NSString *TaskDateKey = @"TaskDateKey";


@interface DataBaseManager : NSObject {
    NSInteger tasksCounter;
}
+ (DataBaseManager *)instance;

- (void)addTask:(NSDictionary *)taskParams;
- (void)addCategory:(NSDictionary *)categoryParams;
- (void)removeTaskById:(NSString *)uniqueId;
- (NSDictionary *)sortBy:(NSString *)descriptor;
- (NSDictionary *)predicate:(NSString *)predicate;

- (TasksCategory *)categoryByName:(NSString *)categoryName;

@end
