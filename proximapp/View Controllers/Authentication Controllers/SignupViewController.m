//
//  SignupViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//
#import "Parse/Parse.h"
#import "SignupViewController.h"


@interface SignupViewController ()
@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _signupButton.layer.cornerRadius = 12.0;
}

- (IBAction)onSignup:(id)sender {
    if ([self validInfo]) {
        PFUser *newUser = [PFUser user];
        
        //TODO: name field
        newUser.username = self.usernameField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                [self alert:@"Unable to register user."];
            } else {
                [self alert:@"User registered successfully"];
                [self performSegueWithIdentifier:@"toLoginSegue" sender:nil];
            }
        }];
    }
}

#pragma mark - helper functions

- (BOOL)validInfo {
    if ([self.usernameField.text isEqual:@""]||[self.passwordField.text isEqual:@""]||[self.emailField.text isEqual:@""]) {
        [self alert:@"Invalid username and password."];
        return false;
    }
    return true;
    
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
