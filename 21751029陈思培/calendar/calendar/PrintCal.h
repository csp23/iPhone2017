//
//  PrintCal.h
//  calendar
//
//  Created by air on 07/10/2017.
//  Copyright © 2017 csp. All rights reserved.
//



#import <Foundation/Foundation.h>

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]) 

@interface PrintCal : NSObject

- (Boolean) isLeapYear:(int)year;


- (int)CheckDaysOfMonthWithYear:(int)year
                       andMonth:(int)month;

- (void)PrintWithMonth:(int)month
               andYear:(int)year;

- (void)PrintWithMonth:(int)month;

- (void)PrintWithYear:(int)year;


@end
