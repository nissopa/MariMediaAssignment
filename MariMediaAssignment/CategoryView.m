//
//  CategoryView.m
//  MariMediaAssignment
//
//  Created by Nissim Pardo on 1/30/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "CategoryView.h"
#import "NSString+Dates.h"

@implementation CategoryView

- (id)initWithCategory:(TasksCategory *)category {
    self = [[NSBundle mainBundle] loadNibNamed:@"CategoryView"
                                         owner:self
                                       options:nil][0];
    if (self) {
        categoryNameLabel.text = category.categoryName;
        self.backgroundColor = [category.categoryColor stringRGB];
        return self;
    }
    return nil;
}

@end
