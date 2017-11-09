//
//  MissionStore.m
//  To_do_list
//
//  Created by air on 07/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import "MissionStore.h"

@interface MissionStore()

@property (nonatomic)NSMutableArray *privateMission;


@end

@implementation MissionStore

+(instancetype)sharedstore
{
    static MissionStore *shareShore = nil;
    if(!shareShore){
        shareShore = [[self alloc]initPrivate];
    }
    
    return shareShore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [MissionStore sharedShore"
                                 userInfo:nil];
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    if(self){
        _privateMission = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateMission;
}

- (NSString *)createMission:(NSString *)item
{
    NSString *Item = [item copy];
    [self.privateMission addObject:Item];
    
    return Item;
}

- (void)removeItem:(NSString *)item
{
    [self.privateMission removeObjectIdenticalTo:item];

}


- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;\
{
    if(fromIndex == toIndex)
    {
        return ;
    }
    NSString *item = self.privateMission[fromIndex];
    
    [self.privateMission removeObjectAtIndex:fromIndex];
    
    [self.privateMission insertObject:item atIndex:toIndex];
}

@end
