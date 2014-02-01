//
//  CategoryView.h
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasksCategory.h"


@interface CategoryView : UIView {
    UIColor *categoryColor;
    __weak IBOutlet UILabel *categoryNameLabel;
}
- (id)initWithCategory:(TasksCategory *)category;
@end
