//
//  NSDate+Calculation.m
//  OddsInPlayPT
//
//  Created by Nissim Pardo on 12/11/13.
//  Copyright (c) 2013 Nissim Pardo. All rights reserved.
//

#import "NSDate+Calculation.h"

//      Date Formats
NSString *const FullDate = @"yyyy-MM-dd";
NSString *const Date = @"yyyy/MM/dd";
NSString *const TitleDate = @"MMM-dd";

@implementation NSDate (Calculation)
- (NSDate *)addDays:(int)days {
    return [self dateByAddingTimeInterval:60*60*24*days];
}

- (NSString *)inString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:FullDate];
    return [dateFormat stringFromDate:self];
}

- (NSString *)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:Date];
    return [dateFormat stringFromDate:self];
}

- (NSString *)inLetters {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:TitleDate];
    return [dateFormat stringFromDate:self];
}

- (NSInteger)daysTo:(NSDate *)date {
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:self];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:date];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference day];
}

- (NSInteger)diffInMinutes:(NSDate *)toDate {
    NSInteger days = [self daysTo:toDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *fromComp = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
    NSDateComponents *toComp = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:toDate];
    NSInteger hour = toComp.hour - fromComp.hour;
    NSInteger minute = toComp.minute - fromComp.hour;
    NSInteger diff = days * 24 * 60 + hour * 60 + minute;
    return diff;
}
@end
