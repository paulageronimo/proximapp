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
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupView {
    PFUser *currentUser = [PFUser currentUser];
    
    _usernameField.placeholder = currentUser.username;
    _emailField.placeholder = currentUser.email;
    _passwordField.placeholder = currentUser.password;
    
    if (currentUser[@"isBusiness"]) {
        [_profileTypeSwitch setOn:YES];
    } else {[_profileTypeSwitch setOn:NO];}
}
//TODO: leave it on/off respectively

- (IBAction)onProfileSwitch:(id)sender {
    if (_profileTypeSwitch.isOn) {
        _profileTypeLabel.text = @"Business";
        
        [self switchProfileType: @YES];
    } else {
        _profileTypeLabel.text = @"Personal";
        [self switchProfileType: @NO];
        
    }
}

- (void)switchProfileType: (NSNumber *)boolean {
    PFUser *currentUser = [PFUser currentUser];
      currentUser[@"isBusiness"] = boolean;
     
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          if (succeeded) {
              [self alert:@"User profile type switched."];
              [self performSegueWithIdentifier:@"toSettingsSegue" sender:nil];
          } else {
              [self alert:@"Unable to switch profile."];
          }
    }];
}

//TODO: implement save button

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