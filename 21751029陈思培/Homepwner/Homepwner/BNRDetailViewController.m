//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by air on 05/01/2018.
//  Copyright © 2018 csp. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRitem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"


@interface BNRDetailViewController ()
<UINavigationBarDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate, UIPopoverControllerDelegate>

//@property (strong, nonatomic) UIPopoverController *imagePickerPopver;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end

@implementation BNRDetailViewController

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)updateFonts
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberField.font = font;
    self.valueLabel.font = font;
    self.dateLabel.font = font;
    
    self.nameField.font = font;
    self.serialNumberField.font = font;
    self.valueField.font = font;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
    
//    for(UIView *subview in self.view.subviews){
//        if([subview hasAmbiguousLayout]){
//            [subview exerciseAmbiguityInLayout];
//        }
//    }
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if(self){
        if (isNew){
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                       target:self
                                                                                       action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    
    NSNotificationCenter *defaultCenter =
    [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(updateFonts)
                          name:UIContentSizeCategoryDidChangeNotification
                        object:nil];
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initalizer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}



-(void)prepareViewForOrientation:(UIInterfaceOrientation)orientation
{
    if([UIDevice currentDevice].userInterfaceIdiom== UIUserInterfaceIdiomPad){
        return;
    }
    //是否横向
    if(UIInterfaceOrientationIsLandscape(orientation)){
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }else{
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self prepareViewForOrientation:toInterfaceOrientation];
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.item setThumbnailFromImage:image];
    
    [[BNRImageStore shareStore]setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewForOrientation:io];
    
    
    BNRitem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    //根据itemKey,从BNRImageStore对象获取照片
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore shareStore] imageForKey:itemKey];
    //将得到的照片赋给UIImage对象
    self.imageView.image = imageToDisplay;
    
    [self updateFonts];
}

- (void)setItem:(BNRitem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //取消当前的第一响应对象
    [self.view endEditing:YES];
    
    BNRitem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nameField.delegate = self;
    _serialNumberField.delegate = self;
    _valueField.delegate = self;
}

//- (void)viewDidLayoutSubviews
//{
//    for (UIView *subview in self.view.subviews){
//        if([subview hasAmbiguousLayout])
//            NSLog(@"AMBIGUOUS:%@",subview);
//    }
//}

//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
