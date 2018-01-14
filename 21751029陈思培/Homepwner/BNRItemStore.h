//
//  BNRItemStore.h
//  Homepwner
//
//  Created by air on 05/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRitem;


@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRitem *)createItem;

- (void)removeItem:(BNRitem *)item;

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;

- (BOOL)saveChanges;

@end
