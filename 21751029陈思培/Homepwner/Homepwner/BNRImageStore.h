//
//  BNRImageStore.h
//  Homepwner
//
//  Created by air on 06/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject
+ (instancetype)shareStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)kay;
- (NSString *)imagePathForKey:(NSString *)key;
@end
