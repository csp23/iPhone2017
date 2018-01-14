//
//  BNRItemCellTableViewCell.m
//  Homepwner
//
//  Created by air on 11/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import "BNRItemCellTableViewCell.h"


@implementation BNRItemCell : UITableViewCell
- (IBAction)showImage:(id)sender
{
    //检查Block是否存在
    if(self.actionBlock){
        self.actionBlock();
    }
}


@end
