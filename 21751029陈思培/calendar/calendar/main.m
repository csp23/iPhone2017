//
//  main.m
//  calendar
//
//  Created by air on 04/10/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrintCal.h"


Boolean isLeapYear(int year)
{
    return year %400||(year %4 == 0 && year %100 !=0);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PrintCal *cal = [[PrintCal alloc] init];
        
        int year,month;
        
      //  printf("%d\n%s\n%s\n%d\n",argc,argv[1],argv[2],strcmp(argv[2],"-m"));
        
        if (argc == 2) {
            NSDate *date=[NSDate date];
            NSDateFormatter *dateform=[[NSDateFormatter alloc] init];
            [dateform setDateFormat:@"MM"];
            NSString *DateString=[dateform stringFromDate:date];
            month=[DateString intValue];
            [cal PrintWithMonth:month];
        }
        
        else if(argc == 3 ){
            year = atoi(argv[2]);
            
            if (year>=1 && year<=9999) {
                [ cal PrintWithYear: year];

            } else {
                printf("sorry you input year out of range\n");
            }
        }
        
        else if(argc == 4 && !strcmp(argv[2],"-m")){
            
            month = atoi(argv[3]);
        
            if (month>=1 && month<=12) {
                [cal PrintWithMonth:month];
            }
            else {
                printf("sorry you input month out of range\n");
            }
        }
                
        else if(argc == 4){
            
            year = atoi(argv[2]);
            month = atoi(argv[3]);

            if((month>=1 && month<=12)&&(year>=1 && year<=9999))
                [cal PrintWithMonth:month andYear:year];
            else {
                printf("sorry you input out of range\n");
            }
        }
        else{
            printf("wrong usage\n");

        }
        
    }
    return 0;
}
