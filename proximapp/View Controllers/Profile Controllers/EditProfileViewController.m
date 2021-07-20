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

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) setupView {
    PFUser *currentUser = [PFUser currentUser];
    
    _usernameField.placeholder = currentUser.username;
    _emailField.placeholder = currentUser.email;
    _passwordField.placeholder = currentUser.password;
    
}

-(IBAction) onProfileSwitch:(id)sender {
    if (_profileTypeSwitch.isOn) {
        _profileTypeLabel.text = @"Business";
        _profileTypeSwitch.on;
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"isBusiness"] = @YES;
      [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          //TODO: alarmming succeess
        } else {
          //TODO: alarming error to user
        }
      }];
        
        
    } else {
        _profileTypeLabel.text = @"Personal";
        !_profileTypeSwitch.on;
        PFUser *currentUser = [PFUser currentUser];
          currentUser[@"isBusiness"] = @NO;
          [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
              // The PFUser has been saved.
            } else {
              // There was a problem, check error.description
            }
          }];
        
    }
    
}



@end
