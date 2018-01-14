//
//  BNRItemCellTableViewCell.h
//  Homepwner
//
//  Created by air on 11/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (copy, nonatomic) void (^actionBlock)(void);
@end
