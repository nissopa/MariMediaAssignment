//
//  RegisterationViewController.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "RegisterationViewController.h"
#import "DataBaseManager.h"

@interface RegisterationViewController () {
    __weak IBOutlet UIButton *start;
}

@end

@implementation RegisterationViewController

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
    [[DataBaseManager instance] initializeDB:^(NSManagedObjectContext *context) {
        if (context) {
            start.hidden = NO;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)credentialsCorrect:(UIButton *)sender {
    [self performSegueWithIdentifier:@"EnterTaskManager" sender:nil];
}

@end
