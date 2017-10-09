//
//  Month.m
//  calendar
//
//  Created by air on 04/10/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import "Month.h"
#import <Foundation/Foundation.h>

static int Monthdays[]={31,28,31,30,31,30,31,31,30,31,30,31};

static char *MonthName[] = {"January", "Fabruary", "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December"};

NSString *WeekName = @"Su Mo Tu We Th Fr Sa";


@implementation Month


- (NSString *)CheckfdayOfmonth:(int)month{
    NSString *M = [[NSString alloc]initWithFormat:@"%s",MonthName[month]];
    
    return M;
}



- (instancetype)initWithmonth:(int)month
                         year:(int)year
               numberOfMonth:(int)nOfMonth
              firstDayOfMonth:(int)fdayOfmonth
{
    self = [super init];
    
    if(self){
        _year = [[NSString alloc] initWithFormat:@"%d",year];
        _month = [self CheckfdayOfmonth:month];
        _numberOfMonth = nOfMonth;
        _firstDay = fdayOfmonth;
        _blank = [[NSMutableString alloc] initWithString:@"                    "];
        _days = [[NSMutableArray alloc]init];
        _days[0] = [[NSMutableString alloc] initWithString:@"                    "];
        _days[1] = [[NSMutableString alloc] initWithString:@"                    "];
        _days[2] = [[NSMutableString alloc] initWithString:@"                    "];
        _days[3] = [[NSMutableString alloc] initWithString:@"                    "];
        _days[4] = [[NSMutableString alloc] initWithString:@"                    "];
        _days[5] = [[NSMutableString alloc] initWithString:@"                    "];
        
    }
    
    NSInteger lMonth = [_month length]/2;
//    NSMutableString *tMonthDescription = [[NSMutableString alloc]initWithString:_blank];
    NSInteger startReplace;
    if([_month length] % 2){
        startReplace = 9-lMonth;
    }
    else{
        startReplace = 10-lMonth;
    }
    [_blank replaceCharactersInRange:NSMakeRange(startReplace, [_month length]) withString:_month];
    
    for(int i=0, j=_firstDay*3, count=1;count<=_numberOfMonth; count++){
        NSString *sCount = [[NSString alloc]init];
        sCount = [NSString stringWithFormat:@"%d", count];
        if(count<10){
            [_days[i] replaceCharactersInRange:NSMakeRange(j+1, 1) withString:sCount];
        }
        else{
            [_days[i] replaceCharactersInRange:NSMakeRange(j, 2) withString:sCount];
        }
        if(j<18)
            j+=3;
        else{
            j=0;
            i++;
        }
    }

    
    
    return self;
}





//- (void)PrintFirstLine:{
//    NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",_blank,WeekName,_days[0],_days[1],_days[2],_days[3],_days[4],_days[5]);
//}


@end
