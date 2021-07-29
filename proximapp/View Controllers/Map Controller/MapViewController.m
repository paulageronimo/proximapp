//
//  MapViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/20/21.
//

#import "LocationsViewController.h"
#import "MapViewController.h"
#import "PhotoAnnotation.h"
#import "Parse/Parse.h"
#import "User.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *onNewPostButton;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self setupView];
    [self setupMapView];
}

- (void)setupView {
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser[@"isBusiness"] boolValue]) {
        _onNewPostButton.hidden = NO;
    } else {
        _onNewPostButton.hidden = YES;
    }
}

- (void)setupMapView {
    PFUser *currentUser = [PFUser currentUser];
    PFGeoPoint *location = currentUser[@"location"];
    
    MKCoordinateRegion region =MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.latitude, location.longitude),
                                MKCoordinateSpanMake(0.025, 0.025));
    [self.mapView setRegion:region animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
     MKAnnotationView *annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
     if (annotationView == nil) {
         annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
         annotationView.canShowCallout = true;
         annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
     }

     UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
     imageView.image = [UIImage imageNamed:@"camera-icon"];
    
    PhotoAnnotation *photoAnnotationItem = annotation;
    imageView.image = photoAnnotationItem.photo;
    annotationView.image = photoAnnotationItem.photo;
    return annotationView;
 }

- (IBAction)onNewPostButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.selectedImage = info[UIImagePickerControllerEditedImage];

    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"tagSegue" sender:nil];
    }];
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    [self.navigationController popViewControllerAnimated:true];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue,
                                   longitude.floatValue);
    PhotoAnnotation *point = [PhotoAnnotation new];
    point.coordinate = coordinate;
    point.photo = [self resizeImage:self.selectedImage withSize:CGSizeMake(50.0, 50.0)];
    [self.mapView addAnnotation:point];
}

- (IBAction)setMap:(id)sender {
    switch(((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            _mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
            break;
    }
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;

    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

@end
