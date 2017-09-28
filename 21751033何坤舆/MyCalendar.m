//
//  mCalendar.m
//  cal
//
//  Created by 何坤舆 on 2017/9/27.
//  Copyright © 2017年 何坤舆. All rights reserved.
//
#import "MyCalendar.h"
static const char* numStr[] = {"", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"};
@implementation MyCalendar
+(bool) isLegal:(const char*) str
{
    for (int i = 0; i < strlen(str); i++)
        if (str[i] < '0' || str[i] > '9')
            return false;
    return true;
}

+(bool) isMonth:(NSUInteger) month
{
    return month >= 1 && month <= 12;
}
/**
 * showCalendar()
 * 在控制台输出第year年，从minMonth到maxMonth的所有日历，每行显示times个日历
 * @param {NSUinteger} year - 输入年份
 * @param {NSUInteger} minMonth - 查询年份的左边界
 * @param {NSUInteger} maxMoth - 查询年份的右边界
 * @param {NSUInteger} times - 日历显示每行的个数
 **/
+(void) showCalendar:(NSUInteger) year minMonth:(NSUInteger) minMonth maxMonth:(NSUInteger) maxMonth
times:(NSUInteger) times
{
    //控制年份的输出，当只显示一个日历的时候，需要特殊处理
    if (maxMonth - minMonth + 1 < times) {
        times = maxMonth - minMonth + 1;
    }

    NSUInteger spaceNum = times * 20;
    spaceNum = spaceNum/2;
    if (times >= 2) {
        for (int i = 0; i < spaceNum; i++) {
            printf(" ");
        }
        printf("%04lu\n\n", year);
    }
    else if (times == 1 && maxMonth - minMonth > 0) {
        printf("       %04lu\n\n", year);
    }
    else if (maxMonth == minMonth) {
        printf("     %s月 %04lu\n", numStr[minMonth], year);
    }

    //创建calendar对象
    NSCalendar* calendar = [NSCalendar currentCalendar];

    //创建compt对象
    NSDateComponents* compt = [[NSDateComponents alloc] init];

    //arrFirstDay[i]表示当前年份中，第i个月的第一天是星期几
    NSUInteger arrFirstDay[13];

    //arrDayCount[i]表示当前年份中，第i个月的天数
    NSUInteger arrDayCount[13];

    //初始化两个数组都为0，查询范围以外的月份信息需要置为0
    memset(arrFirstDay, 0, sizeof(arrFirstDay));
    memset(arrDayCount, 0, sizeof(arrDayCount));
    //获得[minMonth, maxMonth]之间的arrFirstDay和arrDayCount
    for (NSUInteger month = minMonth; month <= maxMonth; month++)
    {
        [compt setYear:year];
        [compt setMonth:month];
        [compt setDay:1];

        //根据NSCalendar对象和NSDateComponents对象，创建NSDate对象
        NSDate *date = [calendar dateFromComponents:compt];

        NSUInteger unFlag = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday);

        compt = [calendar components:unFlag fromDate:date];
        NSUInteger day = [compt day];
        NSUInteger week = [compt weekday];
        NSUInteger firstDayOfMonth = week - day%7 + 1;

        //返回一个在inUnit中的Unit的个数，这里返回的是每月的日期
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        NSUInteger dayCount = range.length;
        arrFirstDay[month] = firstDayOfMonth;
        arrDayCount[month] = dayCount;
    }
    //日历输出步骤
    NSUInteger cnt[12];
    for (NSUInteger month = minMonth; month <= maxMonth; month += times)
    {
        //本行输出月份次数
        if (maxMonth - month + 1 < times) times = maxMonth - month + 1;

        //输出月份头部
        if (minMonth != maxMonth)
        {
            for (int t = 0; t < times; t++)
            {
                //超过十一月份调整输出格式
                if (month + t < 11)
                    printf("        %s月          ", numStr[month + t]);
                else printf("       %s月         ", numStr[month + t]);
            }
            printf("\n");
        }

        //输出每行星期
        for (int t = 0; t < times; t++)
            printf("日 一 二 三 四 五 六  ");
        printf("\n");

        memset(cnt, 0, sizeof(cnt));
        //cnt记录每行月份的各自的日期
        for (int i = 0; i < times; i++) cnt[i] = 1;
        //每月不会超过6行日期
        for (int i = 0; i < 6; i++)
        {
            for (int t = 0; t < times; t++)
            {
                NSUInteger weekOfEachMonth = 1;
                //特殊处理第一行的输出,输出1号日期前面的空格
                if (i == 0)
                {
                    for (int j = 1; j < arrFirstDay[month + t]; j++)
                    {
                        printf("   ");//占位3个空格
                    }
                    weekOfEachMonth = arrFirstDay[month + t];
                }
                for (NSUInteger j = weekOfEachMonth; j <= 7; j++)
                {
                    //特殊处理星期日下的日期格式控制，日期位占2个字符位，向右对齐
                    //如果是星期日或者输出的是1号
                    if (j == 1 || cnt[t] == 1)
                    {
                        //已经输出完本月日期
                        if (cnt[t] > arrDayCount[month + t])
                        {
                            printf("  ");
                        }
                        else printf("%2lu", cnt[t]++);
                    }
                    else
                    {
                        if (cnt[t] > arrDayCount[month + t])
                        {
                            printf("   ");
                        }
                        else printf("%3lu", cnt[t]++);
                    }
                    //判断一下是否输出'\n'还是"  "
                    if (j == 7)
                    {
                        if (t == times - 1) printf("\n");
                        else printf("  ");
                    }
                }
            }
        }
    }
}
@end
