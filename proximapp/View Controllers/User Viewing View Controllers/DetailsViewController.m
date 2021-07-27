//
//  DetailsViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/24/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import <Parse/Parse.h>
#import "LocationsViewController.h"
#import "PhotoAnnotation.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *productLabel; //prodName
//@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIView *cardItemView;
@property (weak, nonatomic) IBOutlet UIButton *visitButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupMapView];
}

- (void)setupView {
    _cardItemView.layer.cornerRadius = 12.0;
    _productLabel.layer.cornerRadius = 12.0;
    _priceLabel.layer.cornerRadius = 12.0;
    _logoView.layer.cornerRadius = 12.0;
    _visitButton.layer.cornerRadius = 12.0;
    _pictureView.layer.cornerRadius = 12.0;
    //_mapView.mapType = MKMapTypeHybrid;
    
    self.navBar.title = [@"Post by @" stringByAppendingString:self.post.author.username];

    self.productLabel.text = self.post.prodName;
    self.priceLabel.text = self.post.price;
    // setup image
    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            UIImage *postImg = [UIImage imageWithData:data];
            [self.pictureView setImage:postImg];
        }
    }];
    //TODO: set up user's logo
//    PFUser *currentUser = self.post.author;
//    self.logoView = currentUser.pfp;
    
}
- (void)setupMapView {
    [self.mapView removeAnnotations:_mapView.annotations];
    PFGeoPoint *prodLocation = self.post.author[@"location"];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

    NSLog(@"Custom Annotations start.");
    // Custom Annotations.
    CLLocationCoordinate2D productCoordinates = CLLocationCoordinate2DMake(prodLocation.latitude, prodLocation.longitude);
    //PFUser *currentUser = [PFUser currentUser];
    //PFGeoPoint *userLocation = currentUser[@"location"];
    //CLLocationCoordinate2D userCoordinates = CLLocationCoordinate2DMake(userLocation.latitude, userLocation.longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = {productCoordinates, span};
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = productCoordinates;
//    MKCoordinateRegion region = {{0.0,0.0}, {0.0,0.0}};
//    region.center.latitude = ;
//    region.center.longitude = ;
//    MapPin *pinned = [[MapPin] init];
    point.title = self.post.prodName;
    point.subtitle = self.post.price;
//    pinned.coordinate= region.center;
//    [_mapView addAnnotation:pinned];
    [self.mapView addAnnotation:point];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation) return nil;

    static NSString* Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView* pinView;
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];

    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:Identifier];
        pinView.canShowCallout = YES;
        return pinView;
    }
    pinView.annotation = annotation;
    return pinView;
}

// TODO: onBack, clear the pins marked :)

//- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
//    [self.navigationController popViewControllerAnimated:true];
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
//    PhotoAnnotation *point = [PhotoAnnotation new];
//    point.coordinate = coordinate;
//    point.photo = [self resizeImage:self.selectedImage withSize:CGSizeMake(50.0, 50.0)];
//    [self.mapView addAnnotation:point];
//}
@end
