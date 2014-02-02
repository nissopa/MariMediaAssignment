//
//  Settings.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 2/2/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Settings : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * rememberMe;

@end
