//
//  DataBaseManager.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "DataBaseManager.h"
#import "NSString+Dates.h"

static NSString *UserNameKey = @"UserNameKey";
static NSString *PasswordKey = @"PasswordKey";
static NSString *RemeberMeKey = @"RemeberMeKey";

@implementation DataBaseManager
@synthesize categoryColors = _categoryColors;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize remeberMe = _remeberMe;

+ (DataBaseManager *)instance {
    static DataBaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSURL *)documentPath{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                         inDomains:NSUserDomainMask] lastObject];
    return [url URLByAppendingPathComponent:@"DocumentForDB"];
}

- (NSArray *)categoryColors {
    if (!_categoryColors) {
        _categoryColors = @[BlueColor,
                            YellowColor,
                            PinkColor,
                            GrayColor,
                            GreenColor];
    }
    return _categoryColors;
}

- (void)initializeDB:(DBInitBlock)completionBlock {
    _contextBlock = [completionBlock copy];
    NSURL *url = [self documentPath];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              _context = document.managedObjectContext;
              // First time the app is installed
              _contextBlock(_context);
          }];
    }else if (document.documentState == UIDocumentStateClosed){
        [document openWithCompletionHandler:^(BOOL success) {
            _context = document.managedObjectContext;
            // App runs after deleted from the multitasking
            _contextBlock(_context);
        }];
    }else{
        
        // App came from the background
        _context = document.managedObjectContext;
        _contextBlock(_context);
    }
}

- (void)addTask:(NSDictionary *)taskParams {
    Tasks *task = [NSEntityDescription insertNewObjectForEntityForName:@"Tasks"
                                                inManagedObjectContext:_context];
    task.taskTitle = taskParams[TaskTitleKey];
    task.taskDescription = taskParams[TaskDescriptionKey];
    task.taskDate = [taskParams[TaskDateKey] inDate];
    task.uniqueId = @(tasksCounter).stringValue;
    tasksCounter++;
    task.taskCategory = [self addCategory:@{TaskCategoryKey: taskParams[TaskCategoryKey],
                                            TaskCategoryColor: taskParams[TaskCategoryColor]}];
    task.isDone = @(NO);
}
- (TasksCategory *)addCategory:(NSDictionary *)categoryParams {
    TasksCategory *category = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TasksCategory"];
    request.predicate = [NSPredicate predicateWithFormat:@"categoryName == %@", categoryParams[TaskCategoryKey]];
    NSError *error = nil;
    NSArray *matches = [_context executeFetchRequest:request
                                               error:&error];
    if (!matches || matches.count > 1) {
        NSLog(@"Error with DataBase");
    } else if (!matches.count) {
        category = [NSEntityDescription insertNewObjectForEntityForName:@"TasksCategory"
                                                 inManagedObjectContext:_context];
        category.categoryName = categoryParams[TaskCategoryKey];
        category.categoryColor = categoryParams[TaskCategoryColor];
    } else {
        category = matches.lastObject;
    }
    return category;
}

- (void)removeTaskById:(NSString *)uniqueId {
    
}
- (NSDictionary *)sortBy:(id)descriptor {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tasks"];
    NSError *error = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskCategory.categoryName" ascending:YES],
                                [NSSortDescriptor sortDescriptorWithKey:descriptor ascending:YES]];
    NSArray *matches = [_context executeFetchRequest:request
                                               error:&error];
    return [self arrangeInDictionary:matches];
}

- (NSDictionary *)arrangeInDictionary:(NSArray *)sortedTasks {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (Tasks *task in sortedTasks) {
        if ([dict.allKeys containsObject:task.taskCategory.categoryName]) {
            [dict[task.taskCategory.categoryName] addObject:task];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:task, nil];
            dict[task.taskCategory.categoryName] = array;
        }
    }
    return dict;
}

- (NSDictionary *)predicate:(NSString *)predicate {
    return nil;
}

- (TasksCategory *)categoryByName:(NSString *)categoryName {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TasksCategory"];
    request.predicate = [NSPredicate predicateWithFormat:@"categoryName == %@", categoryName];
    NSError *error = nil;
    return [_context executeFetchRequest:request
                                   error:&error].lastObject;
}

- (NSArray *)fetchCategories {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TasksCategory"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES]];
    NSError *error = nil;
    return [_context executeFetchRequest:request
                                   error:&error];
}

- (NSArray *)categoriesListForPicker {
    NSArray *categories = [self fetchCategories];
    if (categories.count) {
        NSMutableArray *array = [NSMutableArray new];
        for (TasksCategory *category in categories) {
            [array addObject:category.categoryName];
        }
        return [array copy];
    }
    return nil;
}

- (NSString *)userName {
    if (!_userName) {
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:UserNameKey];
    }
    return _userName;
}

- (void)setUserName:(NSString *)userName {
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)password {
    if (!_password) {
        _password = [[NSUserDefaults standardUserDefaults] objectForKey:PasswordKey];
    }
    return _password;
}

- (void)setPassword:(NSString *)password {
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)remeberMe {
    return [[NSUserDefaults standardUserDefaults] boolForKey:RemeberMeKey];
}

- (void)setRemeberMe:(BOOL)remeberMe {
    _remeberMe = remeberMe;
    [[NSUserDefaults standardUserDefaults] setBool:remeberMe forKey:RemeberMeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
