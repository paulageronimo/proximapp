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
        [self getUserLocation];
        [self getUserLocation];
        newUser[@"location"] = newUserLocation;
        
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

- (void)getUserLocation {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self->locationManager requestWhenInUseAuthorization];

    [locationManager startUpdatingLocation];
    
    newUserLocation = [PFGeoPoint geoPointWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {}];
}

@end
