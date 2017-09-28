//
//  JudgeNumber.m
//  Cal
//
//  Created by Yif-JJ on 2017/9/27.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "JudgeNumber.h"

@implementation JudgeNumber

-(BOOL)isNumber:(NSString *)str{
    //这个是匹配数字字符串的正则表达式；
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        //    NSLog(@"匹配");
        
        return true;
    } else {
        //    NSLog(@"不匹配");
        
        return false;
    }
}
@end
