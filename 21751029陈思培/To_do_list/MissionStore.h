//
//  MissionStore.h
//  To_do_list
//
//  Created by air on 07/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MissionStore : NSObject

@property (nonatomic, readonly)NSArray *allItems;

+ (instancetype)sharedstore;
- (NSString *)createMission:(NSString *)item;
- (void)removeItem:(NSString *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
@end
