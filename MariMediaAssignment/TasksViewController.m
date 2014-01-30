//
//  TasksViewController.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "TasksViewController.h"
#import "TaskCell.h"
#import "CategoryView.h"
#import "DataBaseManager.h"
#import "AddTaskViewController.h"

@interface TasksViewController () <UITableViewDataSource, UITableViewDelegate, AddTaskViewControllerDelegate>{
    __weak IBOutlet UITableView *tasksTV;
    NSDictionary *tasksDict;
    NSArray *sortedKeys;
}

@end

@implementation TasksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sortChanged:(UISegmentedControl *)sender {
}


- (IBAction)addTask:(UIButton *)sender {
    AddTaskViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    addVC.view.frame = self.view.bounds;
    [self addChildViewController:addVC];
    [self.view addSubview:addVC.view];
}


#pragma mark UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sortedKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasksDict[sortedKeys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"TaskCell";
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:Identifier];
    }
    [cell loadTaskCell:tasksDict[sortedKeys[indexPath.section]][indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CategoryView *categoryView = [[CategoryView alloc] initWithCategory:[[DataBaseManager instance] categoryByName:sortedKeys[section]]];
    return categoryView;
}

#pragma mark AddTaskViewControllerDelegate methods 
- (void)addTask:(AddTaskViewController *)taskVC addTaskParams:(NSDictionary *)taskParams {
    [[DataBaseManager instance] addTask:taskParams];
    [tasksTV reloadData];
}
@end
