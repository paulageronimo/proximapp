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

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

// additional functions, for cleanliness and organization
-(BOOL)validInfo {
    if ([self.usernameField.text isEqual:@""]||[self.passwordField.text isEqual:@""]) {
        [self alert:@"Invalid username and password."];
        return false;
    }
    return true;
    
}

-(void) alert: (NSString *)errorMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification"
    message:errorMessage
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
