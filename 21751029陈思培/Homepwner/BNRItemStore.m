//
//  BNRItemStore.m
//  Homepwner
//
//  Created by air on 05/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRitem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

#pragma mark - init

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
//    if(!sharedStore){
//        sharedStore = [[self alloc]initPrivate];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc]initPrivate];});
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singletion"
                                   reason:@"Use + [BNRItemStore sharedStore]"
                                 userInfo:nil];
    
    return nil;
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BNRitem *)createItem
{
    BNRitem *item = [[BNRitem alloc] init];
    
    [self.privateItems addObject:item];
    
    return item;
}


- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    //如果成功就返回YES
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}


- (instancetype)initPrivate
{
    self = [super init];
    if(self){
        //_privateItems = [[NSMutableArray alloc]init];
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!_privateItems){
            _privateItems = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}



- (void)removeItem:(BNRitem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRImageStore shareStore]deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;
{
    if(fromIndex == toIndex){
        return;
    }
    BNRitem *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}


@end
