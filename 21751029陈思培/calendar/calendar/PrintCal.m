//
//  PrintCal.m
//  calendar
//
//  Created by air on 07/10/2017.
//  Copyright © 2017 csp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PrintCal.h"

@implementation PrintCal


//定义静态常量
static char *MonthName[] = {"0","January", "Fabruary", "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December"};

static int Monthdays[]={31,28,31,30,31,30,31,31,30,31,30,31};

NSString *WeekName = @"Su Mo Tu We Th Fr Sa";

//判断闰年
- (Boolean) isLeapYear:(int)year
{
    return year %400||(year %4 == 0 && year %100 !=0);
}

//求此年此月有多少天
- (int)CheckDaysOfMonthWithYear:(int)year
                       andMonth:(int)month
{
    if([self isLeapYear: year]&&month==2)
        return 29;
    else
        return Monthdays[month-1];
}

//此年此月的第一天是周几
- (int)CheckFDaysofMonthWithYear:(int)year
                        andMonth:(int)month
{
    int day = (year-1)*365+(year-1)/4-(year-1)/100+(year-1)/400;
    for(int i=0;i<month-1;i++){
        if(i!=1)
            day=day+Monthdays[i];
        else if([self isLeapYear:year])
            day=day+29;
        else
            day=day+28;
    }
    return (day+1)%7;
}


- (void)PrintWithMonth:(int)month
             andYear:(int)year
{
    
    
    NSString *Tittle = [[NSString alloc]initWithFormat:@"%s %d",MonthName[month],year];
    int DaysOfMonth = [self CheckDaysOfMonthWithYear:year
                                            andMonth:month];
    int FirstDay = [self CheckFDaysofMonthWithYear:year andMonth:month];
        NSMutableString *blank = [[NSMutableString alloc] initWithString:@"                    "];
        NSMutableArray *days = [[NSMutableArray alloc]init];
        days[0] = [[NSMutableString alloc] initWithString:@"                    "];
        days[1] = [[NSMutableString alloc] initWithString:@"                    "];
        days[2] = [[NSMutableString alloc] initWithString:@"                    "];
        days[3] = [[NSMutableString alloc] initWithString:@"                    "];
        days[4] = [[NSMutableString alloc] initWithString:@"                    "];
        days[5] = [[NSMutableString alloc] initWithString:@"                    "];
    
    
    NSInteger LTittle = [Tittle length]/2;
    //    NSMutableString *tMonthDescription = [[NSMutableString alloc]initWithString:_blank];
    NSInteger startReplace;
    if([Tittle length] % 2){
        startReplace = 9-LTittle;
    }
    else{
        startReplace = 10-LTittle;
    }
    [blank replaceCharactersInRange:NSMakeRange(startReplace, [Tittle length] ) withString:Tittle];
    
    for(int i=0, j=FirstDay*3, count=1;count<=DaysOfMonth; count++){
        NSString *sCount = [[NSString alloc]init];
        sCount = [NSString stringWithFormat:@"%d", count];
        if(count<10){
            [days[i] replaceCharactersInRange:NSMakeRange(j+1, 1) withString:sCount];
        }
        else{
            [days[i] replaceCharactersInRange:NSMakeRange(j, 2) withString:sCount];
        }
        if(j<18)
            j+=3;
        else{
            j=0;
            i++;
        }
    }
    
    NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",blank,WeekName,days[0],days[1],days[2],days[3],days[4],days[5]);

}



- (void)PrintWithMonth:(int)month
{
    NSDate *date=[NSDate date];
    NSDateFormatter *dateform=[[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"YYYY"];
    NSString *DateString=[dateform stringFromDate:date];
    int year=[DateString intValue];
    [self PrintWithMonth:month andYear:year];
    
}


- (void)PrintWithYear:(int)year
{
    
    NSMutableArray *months = [[NSMutableArray alloc]init];
    
    months[0] = [[NSMutableString alloc] initWithString:@"                                                              "];
    NSString *Year = [[NSString alloc]initWithFormat:@"%d",year];
    [months[0] replaceCharactersInRange:NSMakeRange(29, 4 ) withString:Year];

    
    for(int month=1;month<=12;month++){
        
        NSString *Tittle = [[NSString alloc]initWithFormat:@"%s",MonthName[month]];
        int DaysOfMonth = [self CheckDaysOfMonthWithYear:year
                                                andMonth:month];
        int FirstDay = [self CheckFDaysofMonthWithYear:year andMonth:month];
        NSMutableString *blank = [[NSMutableString alloc] initWithString:@"                    "];
        NSInteger LTittle = [Tittle length]/2;
        NSInteger startReplace;
        if([Tittle length] % 2){
            startReplace = 9-LTittle;
        }
        else{
            startReplace = 10-LTittle;
        }
        [blank replaceCharactersInRange:NSMakeRange(startReplace, [Tittle length] ) withString:Tittle];
        
        
        
        NSMutableArray *days = [[NSMutableArray alloc]init];
        days[0] = [[NSMutableString alloc] initWithString:blank];
        days[1] = [[NSMutableString alloc] initWithString:WeekName];
        days[2] = [[NSMutableString alloc] initWithString:@"                    "];
        days[3] = [[NSMutableString alloc] initWithString:@"                    "];
        days[4] = [[NSMutableString alloc] initWithString:@"                    "];
        days[5] = [[NSMutableString alloc] initWithString:@"                    "];
        days[6] = [[NSMutableString alloc] initWithString:@"                    "];
        days[7] = [[NSMutableString alloc] initWithString:@"                    "];
        
        
        
        
        for(int i=2, j=FirstDay*3, count=1;count<=DaysOfMonth; count++){
            NSString *sCount = [[NSString alloc]init];
            sCount = [NSString stringWithFormat:@"%d", count];
            if(count<10){
                [days[i] replaceCharactersInRange:NSMakeRange(j+1, 1) withString:sCount];
            }
            else{
                [days[i] replaceCharactersInRange:NSMakeRange(j, 2) withString:sCount];
            }
            if(j<18)
                j+=3;
            else{
                j=0;
                i++;
            }
        }
        months[month] = [[NSMutableArray alloc] initWithArray:days];
    
    }
    
    NSLog(@"\n%@\n\n",months[0]);
    
    for(int Count=1;Count<=12;Count=Count+3){
        for(int Line=0; Line<8;Line++){
            for(int i=0;i<3;i++){
                const char * a =[months[Count+i][Line] UTF8String];
                printf("%s", a);
            if(i<2)
                printf("%s","  ");
            }
            printf("%c",'\n');
        }
    }
    
    
    
}
@end
