//
//  BNRitem.h
//  RandomItem
//
//  Created by air on 28/09/2017.
//  Copyright © 2017 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRitem : NSObject<NSCoding>


@property (nonatomic, copy)NSString *itemName;
@property (nonatomic, copy)NSString *serialNumber;
@property (nonatomic)int valueInDollars;
@property (nonatomic, readonly, strong)NSDate *dateCreated;
@property (nonatomic, copy)NSString *itemKey;
@property (nonatomic, strong)UIImage *thumbnail;

- (void)setThumbnailFromImage:(UIImage *)image;
//BNR类方法初始化
+ (instancetype)randomItem;


//BNRItem实例方法初始化方法
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;


@end
