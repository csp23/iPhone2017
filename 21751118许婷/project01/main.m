//
//  main.m
//  myCal
//
//  Created by ting xu on 2017/10/6.
//  Copyright © 2017年 ting xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Cal *newCal = [[Cal alloc] init];
        NSString *result = [newCal calWithArgc:argc andArgv:argv];
        printf("%s\n",result.UTF8String);
    }
    return 0;
}
