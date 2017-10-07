//
//  Cal.m
//  myCal
//
//  Created by ting xu on 2017/10/6.
//  Copyright © 2017年 ting xu. All rights reserved.
//
#import "Cal.h"

@implementation Cal


/**
 主方法，多种输入情况，输出统一结果

 @param argc 参数个数 1 2 3 分别对应空参数、某一年、某一月
 @param argv 参数值 某一年：*argv[1]年；某一月：*argv[1]月，*argv[2]年
 @return 结果字符串
 */
- (NSString *)calWithArgc:(int)argc andArgv:(const char **)argv {
    switch(argc) {
        case 1: {
            NSDate *now = [NSDate date];
            return [self calForDate:now];
            break;
        }
        case 2: {
            int year = atoi(argv[1]);
            if(year<1 || year>9999){
                return [NSString stringWithFormat:@"cal: year %d not in range 1..9999\n",year];
            }
            return [self calForYear:year];
            break;
        }
        case 3: {
            int month = atoi(argv[1]);
            int year = atoi(argv[2]);
            if(month<1 || month>12){
                return [NSString stringWithFormat:@"cal: %d is not a month number (1..12)\n",month];
            }
            if(year<1 || year>9999){
                return [NSString stringWithFormat:@"cal: year %d not in range 1..9999\n",year];
            }
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM";
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
            return [self calForDate:date];
            break;
        }
        default:
            break;
    }
    return nil;
} // calWithArgc:andArgv:


/**
 针对某一个date，输出当月日历

 @param date 一个NSDate对象，用来代表需要输出的月份
 @return 当月日历字符串
 */
- (NSString *)calForDate:(NSDate *)date {
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
    //取date对应的年份、月份及当月天数、星期
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour fromDate:date];//自动转化为本地时间
    int year = (int)components.year;
    int month = (int)components.month;
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self GMT2Locale:date]];//转换为本地时间，避免时区问题
    int monthRange = (int)range.length;
    //当月第一天
    NSDateComponents *firstDayComponents = [[NSDateComponents alloc] init];
    [firstDayComponents setYear:year];
    [firstDayComponents setMonth:month];
    NSDate *firstDay = [calendar dateFromComponents:firstDayComponents];
    firstDayComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDay];
    int weekday = (int)firstDayComponents.weekday-1;//周日对应weekday为1
    //月日历标题
    NSString *title = [NSString stringWithFormat:@"      %4d %2d       \n",(int)components.year,(int)components.month];
    NSString *subTitle = @"Su Mo Tu We Th Fr Sa\n";
    [retString appendFormat:@"%@%@",title,subTitle];
    //构建日期
    int dayCount = 1;
    int colCount = 0;
    while(weekday>0){
        [retString appendString:@"   "];
        weekday--;
        colCount++;
    }
    while(dayCount<=monthRange){
        while(colCount<7){
            if(colCount==6){
                [retString appendFormat:@"%2d",dayCount];
            }
            else [retString appendFormat:@"%2d ",dayCount];
            colCount++;
            dayCount++;
            if(dayCount>monthRange) break;
        }
        if(dayCount>monthRange){
            while(colCount<7){
                if(colCount==6){
                    [retString appendString:@"  "];
                }
                else [retString appendString:@"   "];
                colCount++;
            }
            break;
        }
        colCount = 0;
        [retString appendString:@"\n"];
    }
    return retString;
} //calForDate:


/**
 针对某一年，输出当年日历

 @param year 一个int型数，用来表示年份
 @return 当年日历字符串
 */
- (NSString *)calForYear:(int)year {
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
    [retString appendFormat:@"                             %4d                             \n\n",year];
    //取出这一年所有月份的日历字符串
    NSMutableArray *monthStringArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    for(int month=1;month<=12;month++){
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
        NSString *monthString = [self calForDate:date];
        //对每个月历字符串进行拆分，以"\n"间隔
        NSMutableArray *tempArray = [monthString componentsSeparatedByString:@"\n"].mutableCopy;
        [monthStringArray addObject:tempArray];
    }
    //构造年份日历字符串
    //每三个月一部分
    for(int i=0;i<12/3;i++){
        int returnFlag=0;//每三个月空行标志
        int maxLineCount=(int)((NSMutableArray *)monthStringArray[3*i]).count;
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(maxLineCount<tempCount){
                maxLineCount = tempCount;
            }
        }
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(tempCount<maxLineCount){
                returnFlag = 1;
                NSMutableArray *tempMutableArray = (NSMutableArray *)monthStringArray[m];
                [tempMutableArray addObject:@"                    "];
            }
        }
        for(int m=0;m<maxLineCount;m++){
            for(int n=3*i;n<3*(i+1);n++){
            [retString appendFormat:@"%@",(NSMutableArray *)monthStringArray[n][m]];
            [retString appendString:@"  "];
            }
            [retString appendString:@"\n"];
        }
        if(!returnFlag){
            [retString appendString:@"\n"];
        }
    }
    return retString;
}

/**
 将GMT时间转化为本地时间，解决时区问题

 @param GMTDate GMT时间
 @return 本地时间
 */
- (NSDate *)GMT2Locale:(NSDate *)GMTDate {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:GMTDate];
    NSDate *localeDate = [GMTDate dateByAddingTimeInterval:interval];
    return localeDate;
}
@end

