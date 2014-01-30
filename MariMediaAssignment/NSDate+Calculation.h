//
//  NSDate+Calculation.h
//  OddsInPlayPT
//
//  Created by Nissim Pardo on 12/11/13.
//  Copyright (c) 2013 Nissim Pardo. All rights reserved.
//

#import <Foundation/Foundation.h>

//      Date Formats
extern NSString *const FullDate;
extern NSString *const TitleDate;


@interface NSDate (Calculation)
- (NSDate *)addDays:(int)days;

//  Returns NSDate as string yyyy-MM-dd
- (NSString *)inString;

// Returns NSDate as string yyyy/mm/dd
- (NSString *)dateString;

//  Resturns NSDate as string MMM-dd
- (NSString *)inLetters;

//  Returns the diff between 2 NSDate
- (NSInteger)daysTo:(NSDate *)date;

// Returns the diff between 2 dates in minutes
- (NSInteger)diffInMinutes:(NSDate *)toDate;

@end
