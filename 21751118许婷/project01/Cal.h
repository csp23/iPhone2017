//
//  Cal.h
//  myCal
//
//  Created by ting xu on 2017/10/6.
//  Copyright © 2017年 ting xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject

- (NSString *)calWithArgc:(int) argc andArgv:(const char **)argv;

- (NSString *)calForDate:(NSDate *)date;

- (NSString *)calForYear:(int)year;

- (NSDate *)GMT2Locale:(NSDate *)GMTDate;
@end
