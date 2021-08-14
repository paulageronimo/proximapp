//
//  EditLocationViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/23/21.
//

#import "EditLocationViewController.h"
#import "LocationsViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface EditLocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation EditLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLocationView];
}

- (void)setLocationView {
    PFUser *currentUser = [PFUser currentUser];
    PFGeoPoint *userLocation = currentUser[@"location"];
    NSNumber *doubleLatitude = [NSNumber numberWithDouble:userLocation.latitude];
    NSNumber *doubleLongitude = [NSNumber numberWithDouble:userLocation.longitude];
    NSString *location = [NSString stringWithFormat:@"%@, %@", [doubleLatitude stringValue], [doubleLongitude stringValue]];
    _locationLabel.text = location;
}


- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    NSLog(@"%@, %@", latitude, longitude);
    [self.navigationController  popToRootViewControllerAnimated:YES];
    NSString *location = [NSString stringWithFormat:@"%@, %@", [latitude stringValue], [longitude stringValue]];
    _locationLabel.text = location;
    PFUser *currentUser = [PFUser currentUser];
    PFGeoPoint *updatedLocation = currentUser[@"location"];
    updatedLocation.latitude = [latitude doubleValue];
    updatedLocation.longitude = [longitude doubleValue];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"locationSegue"]) {
        LocationsViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

@end
