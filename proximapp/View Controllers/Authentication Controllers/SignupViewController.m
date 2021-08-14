//
//  SignupViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//
#import "Parse/Parse.h"
#import "SignupViewController.h"
#import "User.h"

@interface SignupViewController ()
// @property(weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end
static PFGeoPoint *newUserLocation;

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _signupButton.layer.cornerRadius = 12.0;
}

- (IBAction)onSignup:(id)sender {
    if ([self.usernameField.text isEqual:@""]
        ||[self.passwordField.text isEqual:@""]
        ||[self.emailField.text isEqual:@""]) {
        PFUser *newUser = [PFUser user];
        
        newUser.username = self.usernameField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        PFGeoPoint *location;
        location.latitude = 27.44661708289829;
        location.longitude = -99.46378527362778;
        newUserLocation = location;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                [User alert:@"Unable to register user."];
            } else {
                [User alert:@"User registered successfully"];
                [self performSegueWithIdentifier:@"toLoginSegue" sender:nil];
            }
        }];
    }
}

@end
