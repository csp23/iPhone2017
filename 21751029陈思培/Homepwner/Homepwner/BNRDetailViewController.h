//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by air on 05/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRitem;

@interface BNRDetailViewController : UIViewController

-(instancetype)initForNewItem:(BOOL)isNew;

@property(nonatomic, strong)BNRitem *item;
@property(nonatomic, copy)void (^dismissBlock)(void);

@end
