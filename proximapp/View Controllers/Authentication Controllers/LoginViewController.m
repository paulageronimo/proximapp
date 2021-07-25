//
//  LoginViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//
#import "SignupViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginButton.layer.cornerRadius = 12.0;
}

- (IBAction)tapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            //SignupViewController* alert = [alert @"Could not log in user"];//Next, we send the loggedIn message to our new instance ??
            [self alert:error.localizedDescription];
        } else {
            [self performSegueWithIdentifier:@"loggedinSegue" sender:nil];
        }
    }];
}

#pragma mark - helper functions
- (BOOL)validInfo {
    if ([self.usernameField.text isEqual:@""]||[self.passwordField.text isEqual:@""]) {
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
