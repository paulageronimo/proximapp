//
//  EditLocationViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/23/21.
//

#import "EditLocationViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface EditLocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation EditLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    PFGeoPoint *userLocation = currentUser[@"location"];
    _locationLabel.text = (NSString *)userLocation;
}

- (IBAction)onUpdateLocation:(id)sender {
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            //TODO: update locaiton label and location in user file
            PFUser *currentUser = [PFUser currentUser];
            PFGeoPoint *userLocation = currentUser[@"location"];
            self->_locationLabel.text = (NSString *)userLocation;
        }
    }];
}

@end
