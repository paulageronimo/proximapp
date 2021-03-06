//
//  EditProfileViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "User.h"
#import "ProfileViewController.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *profilepicView;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    PFUser *currentUser = [PFUser currentUser];
    
    _nameField.placeholder = currentUser[@"name"];
    _emailField.placeholder = currentUser.email;
    _passwordField.placeholder = @"●●●●●●●●●●●●●";
    _profilepicView.layer.cornerRadius = 75.0;
    
    if ([currentUser[@"isBusiness"] boolValue]) {
        _profileTypeLabel.text = @"Business";
        [_profileTypeSwitch setOn:YES];
    } else {
        _profileTypeLabel.text = @"Personal";
        [_profileTypeSwitch setOn:NO];
    }
}


- (IBAction)onProfileSwitch:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    //currentUser[@"isBusiness"] = !(NSNumber *)_profileTypeSwitch.isOn;
    currentUser[@"isBusiness"] = [NSNumber numberWithBool:_profileTypeSwitch.isOn];
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self alert:@"User profile type switched."];
            //[ProfileViewController viewDidLoad];
            //[self performSegueWithIdentifier:@"toSettingsSegue" sender:nil];
        } else {
            [self alert:@"Unable to switch profile."];
        }
    }];
    _profileTypeLabel.text = [currentUser[@"isBusiness"] boolValue]?
                                @"Business": @"Personal";
}

- (void)alert: (NSString *)errorMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification"
    message:errorMessage
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

@end
