//
//  BNRImageStore.m
//  Homepwner
//
//  Created by air on 06/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property(nonatomic, strong)NSMutableDictionary *dictionary;


@end

@implementation BNRImageStore

#pragma mark - init

+ (instancetype)shareStore
{
    static BNRImageStore *sharedStore = nil;
    
//    if(!sharedStore){
//        sharedStore = [[self alloc] initPrivate];
//    }
    //多线程
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc]initPrivate];});
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use+[BNRImageStore sharedShore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if(self){
        _dictionary = [[NSMutableDictionary alloc]init];
        //注册低内存警告
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
    //获取路径
    NSString *imagePath = [self imagePathForKey:key];
    //提取JPEG
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    //写入路径
    [data writeToFile:imagePath atomically:YES];
    
}

- (UIImage *)imageForKey:(NSString *)key
{
//return self.dictionary[key];
    UIImage *result = self.dictionary[key];
    
    if(!result){
        NSString *imagePath = [self imagePathForKey:key];
        
        result = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    if(result){
        self.dictionary[key] = result;
    }
    else{
        NSLog(@"Error: unable to find %@", [self imagePathForKey:key]);
    }
    
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    
    [[NSFileManager defaultManager]removeItemAtPath:imagePath
                                              error:nil];
    
}
//根据传入的键创建相应的文件路径
- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}


- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}
@end
