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
@property (weak, nonatomic) IBOutlet UITextField *keywordField;
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
    self.keywordField.delegate = self;
    
    _backgroundView.layer.cornerRadius = 12.0;
}

//TODO: make this code less messy :/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.image = editedImage;
    [self.pictureView setImage:self.image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sharePost:(id)sender {
    if (self.image == nil) {
        [self alert:@"An image has not been selected."];
    } else {
        [self createPost];
    }
}

- (void)createPost {
    CGSize size = CGSizeMake(400, 400);
    UIImage *image = [self resizeImage:self.image withSize:size];
    
    Post *newPost = [Post new];
    
    newPost.image = [Post getPFFileFromImage:image];
    PFUser *currentUser =[PFUser currentUser];
    newPost.author = currentUser;
    newPost.logo = currentUser[@"pfp"];
    newPost.prodName = _productNameField.text;
    newPost.price = _priceField.text;
    newPost.availability = (PFObject *)@YES;
    newPost.keywords = _keywordField.text;

    if (_isAvailable.isOn) {
        newPost[@"isAvailable"] = @YES;
    } else {
        newPost[@"isAvailable"] = @NO;
    }
    //currentPost[@"keywords"] = ;
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
          // TODO: alert that notifies you have posted? send to notification array?
      } else {
          [self alert:@"Unable to be posted."];
      }
    }];
    
    [self exitCreate];
}

- (void)exitCreate {
    self.image = nil;
    [self.pictureView setImage:[UIImage imageNamed:@"image_placeholder"]];
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *HomeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    sceneDelegate.window.rootViewController = HomeViewController;
}

- (IBAction)imageSelected:(id)sender {
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
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    
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

- (void)alert: (NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:dismissAction];
    [self presentViewController:alert animated:YES completion:^{}];
}
@end
