//
//  SignupViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//
#import "Parse/Parse.h"
#import "SignupViewController.h"


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
    if ([self validInfo]) {
        PFUser *newUser = [PFUser user];
        
        //TODO: name field ??
        newUser.username = self.usernameField.text;
        newUser.email = self.emailField.text;
        newUser.password = self.passwordField.text;
        [self getUserLocation];
        [self getUserLocation];
        newUser[@"location"] = newUserLocation;
        
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
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
         if (!(error)) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
         } else {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
         }
     }];
}

@end
