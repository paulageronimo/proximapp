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
#import "Post.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIButton *visitButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setPostView];
    [self setupMapView];
}

- (void)setupView {
    _productLabel.layer.cornerRadius = 12.0;
    _priceLabel.layer.cornerRadius = 12.0;
    _logoView.layer.cornerRadius = 12.0;
    _visitButton.layer.cornerRadius = 12.0;
    _pictureView.layer.cornerRadius = 12.0;
}
     
- (void)setupMapView {
    PFGeoPoint *prodLocation = self.post.author[@"location"];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];

    CLLocationCoordinate2D productCoordinates = CLLocationCoordinate2DMake(prodLocation.latitude,
                                    prodLocation.longitude);

    MKCoordinateSpan span = MKCoordinateSpanMake(0.025, 0.025);
    MKCoordinateRegion region = {productCoordinates, span};
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = productCoordinates;
    
    point.title = self.post.prodName;
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    point.subtitle = [currencyFormatter stringFromNumber:self.post[@"price"]];
    
    [_mapView addAnnotation:point];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation == mapView.userLocation) {
        return nil;
    }

    static NSString* Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView* pinView;
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];

    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:annotation
                   reuseIdentifier:Identifier];
        pinView.canShowCallout = YES;
        return pinView;
    }
    pinView.annotation = annotation;
    return pinView;
}

- (void)setPostView {
    self.navBar.title = [@"Post by @" stringByAppendingString:self.post.author.username];

    self.productLabel.text = self.post.prodName;
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.priceLabel.text = [currencyFormatter stringFromNumber:self.post[@"price"]];
    
    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData * _Nullable data,
                                        NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            UIImage *postImg = [UIImage imageWithData:data];
            [self.pictureView setImage:postImg];
        }
    }];
    self.logoView = self.post.author[@"pfp"];
}

@end
