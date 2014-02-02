//
//  NSString+Dates.h
//  OddsInPlayPT
//
//  Created by Nissim Pardo on 12/11/13.
//  Copyright (c) 2013 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Calculation.h"

@interface NSString (Dates)

//  Get date as string and add days, returns new string
- (NSString *)addDays:(int)days;

//  Get date as string and transform it to NSDate
- (NSDate *)inDate;

//  Get date as letterString and transform it to NSDate
- (NSDate *)lettersInDate;

// Transform string date - yyyy-MM-dd to - MMM-dd and returns as string
- (NSString *)fullDateToLettes;

// Transform letters date - MMM-dd to - yyyy-MM-dd  and returns as string
- (NSString *)lettersToFullDate;

// Returns Date and Time from String
- (NSArray *)dateParams;

// Returns name of date - Today,Tomorrow,Later, Yesterday
- (NSString *)dateName;

// Gets RGB string and transform into UIColor
- (UIColor *)stringRGB;

// Checks valid email address
- (BOOL)isEmailValid;
@end
