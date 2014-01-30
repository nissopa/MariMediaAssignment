//
//  UIColor+RGB.m
//  OddsInPlayPT
//
//  Created by Nissim Pardo on 1/17/14.
//  Copyright (c) 2014 Nissim Pardo. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)
+ (UIColor *)RGB:(float)R G:(float)G B:(float)B {
    return [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1];
}
@end
