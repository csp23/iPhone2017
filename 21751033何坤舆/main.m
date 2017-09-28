//
//  main.m
//  cal
//
//  Created by 何坤舆 on 2017/9/27.
//  Copyright © 2017年 何坤舆. All rights reserved.
//
#import "MyCalendar.h"

int main(int argc, const char* argv[]) {
    @autoreleasepool {

//        showCalendar(2017, 1, 12, 3);
        //创建calendar对象
        NSCalendar *calendar = [NSCalendar currentCalendar];
        //创建date对象
        NSDate *date = [NSDate date];

        NSUInteger unFlag = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday);
        NSDateComponents *compt = [calendar components:unFlag fromDate:date];

        NSUInteger month = [compt month];
        NSUInteger year = [compt year];

        //处理命令行
        for (int i = 0; i < argc; i++)
            printf("%s ", argv[i]);
        printf("\n");

        @try {
            //定义异常
            NSException* exception = [NSException exceptionWithName:@"CommandException"
                                                             reason:@"Command Error"
                                                           userInfo:nil];

            if(argc == 1){
                //cal 输出当前月
                [MyCalendar showCalendar:year minMonth:month maxMonth:month times:1];
            } else {
                //输入非数字
                for (int i = 1; i < argc; i++)
                    if (![MyCalendar isLegal:argv[i]])
                        @throw exception;

                if(argc == 2) {
                    //cal 2017 输出当前年 日历
                    year = atoi(argv[1]);
                    [MyCalendar showCalendar:year minMonth:1 maxMonth:12 times:3];

                } else if(argc == 3) {
                    //cal 9 2017 输出当前月年
                    month = atoi(argv[1]);
                    year  = atoi(argv[2]);
                    if(![MyCalendar isMonth:month]) {
                       @throw exception;
                    }
                    [MyCalendar showCalendar:year minMonth:month maxMonth:month times:1];
                }

            }
        } @catch (NSException* exception) {
            NSLog(@"%@: parameter is illegal!", exception);
        } @finally {
        }
    }
    return 0;
}
