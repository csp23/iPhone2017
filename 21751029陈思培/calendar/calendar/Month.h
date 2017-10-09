//
//  Month.h
//  calendar
//
//  Created by air on 04/10/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Month : NSObject
{
    NSString *_year;
    NSString *_month;
    int _firstDay;
    int _numberOfMonth;
    NSMutableString *_blank;
    NSMutableArray *_days;
}

- (NSString *)CheckfdayOfmonth:(int)month;


- (instancetype)initWithmonth:(int)month
               numberOfMonth:(int)nOfMonth
             firstDayOfMonth:(int)fdayOfmonth;


@end
