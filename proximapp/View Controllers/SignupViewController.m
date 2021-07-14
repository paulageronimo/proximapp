//
//  SignupViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//
#import "Parse/Parse.h"
#import "SignupViewController.h"

@interface SignupViewController ()
@property(weak, nonatomic) IBOutlet UITextField *firstNField;
@property(weak, nonatomic) IBOutlet UITextField *lastNField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)onSignup:(id)sender {
    if ([self validInfo]) {
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        //newUser.firstname = self.firstNField.text;
        //newUser.lastname = self.lastNField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                [self alert:@"Unable to register user."];
            } else {
                [self alert:@"User registered successfully"];
                [self performSegueWithIdentifier:@"toLoginSegue" sender:nil];
                // manually segue to logged in view
            }
        }];
    }
}

-(void) onLogout {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}
// additional functions, for cleanliness and organization
-(BOOL)validInfo {
    if ([self.usernameField.text isEqual:@""]||[self.passwordField.text isEqual:@""]||[self.emailField.text isEqual:@""]) {
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
