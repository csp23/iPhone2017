//
//  mCalendar.h
//  cal
//
//  Created by 何坤舆 on 2017/9/27.
//  Copyright © 2017年 何坤舆. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
+(bool) isLegal:(const char *)str;
+(bool) isMonth:(NSUInteger)month;
+(void) showCalendar:(NSUInteger)year minMonth:(NSUInteger)minMonth maxMonth:(NSUInteger)maxMonth times:(NSUInteger)times;

@end
