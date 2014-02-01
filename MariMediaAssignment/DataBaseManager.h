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

typedef enum CategoryColor {
    CategoryColorBlue,
    CategoryColorYellow,
    CategoryColorPink,
    CategoryColorGray,
    CategoryColorGreen
}CategoryColor;

static NSString *TaskTitleKey = @"TaskTitleKey";
static NSString *TaskDescriptionKey = @"TaskDescriptionKey";
static NSString *TaskDateKey = @"TaskDateKey";
static NSString *TaskCategoryKey = @"TaskCategoryKey";
static NSString *TaskCategoryColor = @"TaskCategoryColor";
static NSString *TaskDoneKey = @"TaskDoneKey";

static NSString *DateDescriptor = @"taskDate";
static NSString *TitleDescriptor = @"taskTitle";

#define BlueColor @"0,0,255"
#define YellowColor @"255,204,102"
#define PinkColor @"255,0,128"
#define GrayColor @"76,76,76"
#define GreenColor @"102,255,204"

typedef void (^DBInitBlock) (NSManagedObjectContext *context);

@interface DataBaseManager : NSObject {
    NSInteger tasksCounter;
    DBInitBlock _contextBlock;
}
+ (DataBaseManager *)instance;

- (void)initializeDB:(DBInitBlock)completionBlock;

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSArray *categoryColors;

- (void)addTask:(NSDictionary *)taskParams;
- (TasksCategory *)addCategory:(NSDictionary *)categoryParams;
- (void)removeTaskById:(NSString *)uniqueId;
- (NSDictionary *)sortBy:(id)descriptor;
- (NSDictionary *)predicate:(NSString *)predicate;
- (TasksCategory *)categoryByName:(NSString *)categoryName;
- (NSArray *)categoriesListForPicker;

@end
