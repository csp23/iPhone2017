//
//  BNRIItemViewController.m
//  Homepwner
//
//  Created by air on 05/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import "BNRItemViewController.h"
#import "BNRitem.h"
#import "BNRItemStore.h"
#import "BNRDetailViewController.h"
#import "BNRItemCellTableViewCell.h"
#import "BNRImageStore.h"
#import "BNRImageViewController.h"

@interface BNRItemViewController() <UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIPopoverPresentationController *imagePopover;

@end

@implementation BNRItemViewController

- (IBAction)addNewItem:(id)sender
{
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    
    BNRitem *newItew = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc]initForNewItem:YES];
    
    detailViewController.item = newItew;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
    
//    NSInteger lastRow = [[[BNRItemStore sharedStore]allItems]indexOfObject:newItew];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
 //   [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

//- (IBAction)toggleEditingMode:(id)sender
//{
//    if(self.isEditing){
//        [sender setTitle:@"Edit"forState:UIControlStateNormal];
//        
//        [self setEditing:NO animated:YES];
//    }else{
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        
//        [self setEditing:YES animated:YES];
//    }
//}

//- (UIView *)headerView
//{
//    if(!_headerView){
//        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    
//    return _headerView;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //注册cell对象
    UINib *nib = [UINib nibWithNibName:@"BNRItemCellTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCellTableViewCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tableView reloadData];
}



- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BNRDetailViewController *detailViewController =[[BNRDetailViewController alloc]init];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRitem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
//        for(int i = 0; i < 5; i++){
//            [[BNRItemStore sharedStore]createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRitem *item = items[indexPath.row];
        [[BNRItemStore sharedStore]removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger i=[[[BNRItemStore sharedStore]allItems]count];
    return i;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell =
//    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
//                                    forIndexPath:indexPath];
//    [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                           reuseIdentifier:@"UITableViewCell"];
    
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCellTableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    BNRitem *item = items[indexPath.row];

//    cell.textLabel.text = [item description];
    
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d",item.valueInDollars];
    cell.thumbnailView.image = item.thumbnail;
    
    cell.actionBlock = ^{
        NSLog(@"Going to show image for %@", item);
        };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row
                                       toIndex:destinationIndexPath.row];
}

@end
