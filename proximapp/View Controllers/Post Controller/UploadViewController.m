//
//  UploadViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "UploadViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "FeedProductCell.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "FeedProductCell.h"

@interface UploadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UITextField *productNameField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UISwitch *isAvailable;
@property (weak, nonatomic) IBOutlet UITextField *keywordFiled;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) UIImage *image;
@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
- (void)setupView {
    self.image = nil;
    self.productNameField.delegate = self;
    self.priceField.delegate = self;
    self.keywordFiled.delegate = self;
    
    [self.isAvailable addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    //_postProduct.layer.cornerRadius = 12.0;
    _backgroundView.layer.cornerRadius = 12.0;
}

- (void)switchChanged:(UISwitch *)sender {
   BOOL value = sender.on;
}

//TODO: make this code less messy :/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
//        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.image = editedImage;
    [self.pictureView setImage:self.image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sharePost:(id)sender {
    if (self.image == nil) {
        NSLog(@"Image not set!");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot create post" message:@"An image has not been selected." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:^{}];
    } else {
        CGSize size = CGSizeMake(400, 400);
        UIImage *image = [self resizeImage:self.image withSize:size];
        //[Post postUserImage:image withCaption:prodName withCompletion:nil];
        [Post postUserImage:image withCaption:self.productNameField.text withCompletion:nil];
        [self exitCreate];
    }
}

- (void)exitCreate {
    self.image = nil;
    [self.pictureView setImage:[UIImage imageNamed:@"image_placeholder"]];
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *HomeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    sceneDelegate.window.rootViewController = HomeViewController;
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)imageSelected:(id)sender {
    NSLog(@"image tapped!");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // camera is available
        UIAlertController *sourcePicker = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *pickCamera = [UIAlertAction actionWithTitle:@"Take picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }];
        UIAlertAction *pickLibrary = [UIAlertAction actionWithTitle:@"Select from photo library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        [sourcePicker addAction:pickCamera];
        [sourcePicker addAction:pickLibrary];
        [sourcePicker addAction:cancelAction];
        [self presentViewController:sourcePicker animated:YES completion:^{}];
    } else {
        //NSLog(@"Camera unavailable so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        //[self performSegueWithIdentifier:@"postSegue" sender:nil];
    }
    
}

@end
