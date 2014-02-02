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

// The colors of categories by RGB vakues
#define BlueColor @"0,0,255"
#define YellowColor @"255,204,102"
#define PinkColor @"255,0,128"
#define GrayColor @"76,76,76"
#define GreenColor @"102,255,204"

// Block for init the DataBase context var
typedef void (^DBInitBlock) (NSManagedObjectContext *context);


@interface DataBaseManager : NSObject {
    NSInteger tasksCounter;
    DBInitBlock _contextBlock;
}
+ (DataBaseManager *)instance;

// Init the Database manager
- (void)initializeDB:(DBInitBlock)completionBlock;

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSArray *categoryColors;


// Settings data for the credentials
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) BOOL remeberMe;


// Adds task to the database
- (void)addTask:(NSDictionary *)taskParams;

// Adds category while creating a task (if already exist no need to create)
- (TasksCategory *)addCategory:(NSDictionary *)categoryParams;

// For deleting task (not implemented)
- (void)removeTaskById:(NSString *)uniqueId;

// Sorts the database
- (NSDictionary *)sortBy:(id)descriptor;

// Get an instance of task by name (unique)
- (TasksCategory *)categoryByName:(NSString *)categoryName;

// Gets an array of categories name
- (NSArray *)categoriesListForPicker;

@end
