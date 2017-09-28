//
//  YearAndMonthNow.m
//  Cal
//
//  Created by Yif-JJ on 2017/9/27.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "YearAndMonthNow.h"

@implementation YearAndMonthNow
- (void)yearAndMonth{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    //这句是说你要获取日期的元素有哪些,中间用|隔开；
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    NSDateComponents *d = [cal components:unitFlags fromDate:date];
    
    _yearNow = (int)[d year];
    _monthNow = (int)[d month];
}
@end
