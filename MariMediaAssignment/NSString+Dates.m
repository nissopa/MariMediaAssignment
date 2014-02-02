//
//  NSString+Dates.m
//  OddsInPlayPT
//
//  Created by Nissim Pardo on 12/11/13.
//  Copyright (c) 2013 Nissim Pardo. All rights reserved.
//

#import "NSString+Dates.h"
#import "UIColor+RGB.h"

@implementation NSString (Dates)

- (NSDate *)inDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = FullDate;
    NSDate *date = [dateFormat dateFromString:self];
    return date;
}

- (NSDate *)lettersInDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = TitleDate;
    NSDate *date = [dateFormat dateFromString:self];
    return date;
}

- (NSString *)addDays:(int)days {
    NSDate *date = [self inDate];
    date = [date addDays:days];
    return [date inString];
}

- (NSString *)fullDateToLettes {
    NSDate *date = [self inDate];
    return [date inLetters];
}

- (NSString *)lettersToFullDate {
    NSDate *date = [self lettersInDate];
    return [date inString];
}

- (NSString *)dateName {
    NSDate *selfDate = [self inDate];
    NSInteger diff = [[NSDate date] daysTo:selfDate];
    switch (diff) {
        case -1:
            return @"Yesterday";
        case 0:
            return @"Today";
        case 1:
            return @"Tomorrow";
    }
    if (diff > 1 || diff < -1) {
        return self;
    }
    return nil;
}

- (NSArray *)dateParams {
    NSArray *params = [self componentsSeparatedByString:@"T"];
    NSString *time = nil;
    NSString *date = nil;
    if (params.count >= 2) {
        time = [params[1] substringToIndex:5];
        date = [params[0] substringFromIndex:5];
        return @[date, time];
    }
    return nil;
}

- (UIColor *)stringRGB {
    NSArray *colorParams = [self componentsSeparatedByString:@","];
    if (colorParams.count > 2) {
        float R = [colorParams[0] floatValue];
        float G = [colorParams[1] floatValue];
        float B = [colorParams[2] floatValue];
        return [UIColor RGB:R G:G B:B];
    }
    return nil;
}

- (BOOL)isEmailValid {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end

