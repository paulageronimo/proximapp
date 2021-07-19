//
//  EditProfileViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onProfileSwitch:(id)sender {
    if (_profileTypeSwitch.on) {
        _profileTypeLabel.text = @"Business";
        PFUser *currentUser = [PFUser currentUser];
        
      currentUser[@"isBusiness"] = NO;

      [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          // The PFUser has been saved.
        } else {
          // There was a problem, check error.description
        }
      }];
        
        
    } else {
        _profileTypeLabel.text = @"Personal";
        PFUser *currentUser = [PFUser currentUser];

          currentUser[@"isBusiness"] = NO;

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
