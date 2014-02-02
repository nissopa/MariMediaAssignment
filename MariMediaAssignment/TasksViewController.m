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
#import "DetailedViewController.h"

@interface TasksViewController () <UITableViewDataSource, UITableViewDelegate, AddTaskViewControllerDelegate, TaskCellDelegate>{
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
    
    // Loading the stored data to the table
    [self loadTable:TitleDescriptor];
}


// Gets the data from coredata and sorting the sections by ABC
- (void)loadTable:(NSString *)descriptor {
    tasksDict = [[DataBaseManager instance] sortBy:descriptor];
    sortedKeys = [tasksDict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [tasksTV reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Updating the table when clicking on the sort button (Date or ABC)
- (IBAction)sortChanged:(UISegmentedControl *)sender {
    NSString *descriptor = sender.selectedSegmentIndex ? TitleDescriptor : DateDescriptor;
    [self loadTable:descriptor];
}


// Calling the assTaskController
- (IBAction)addTask:(UIButton *)sender {
    AddTaskViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    addVC.delegate = self;
    addVC.view.frame = self.view.bounds;
    [self addChildViewController:addVC];
    [self.view addSubview:addVC.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setTask:sender];
}


// Methods for arranging the table
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
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CategoryView *categoryView = [[CategoryView alloc] initWithCategory:[[DataBaseManager instance] categoryByName:sortedKeys[section]]];
    return categoryView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"Detailed" sender:tasksDict[sortedKeys[indexPath.section]][indexPath.row]];
}

// Listening to events on the addtaskcontroller
#pragma mark AddTaskViewControllerDelegate methods 
- (void)addTask:(AddTaskViewController *)taskVC addTaskParams:(NSDictionary *)taskParams {
    [[DataBaseManager instance] addTask:taskParams];
    [self loadTable:TitleDescriptor];
}

#pragma mark TaskCellDelegate methods
- (void)taskCell:(TaskCell *)taskCell didSelected:(Tasks *)task {
    task.isDone = @(YES);
}
@end
