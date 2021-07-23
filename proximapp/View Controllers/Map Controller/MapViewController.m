//
//  MapViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/20/21.
//

#import "LocationsViewController.h"
#import "MapViewController.h"
#import "PhotoAnnotation.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    //MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    //TODO: Get coordinates directly from current user info instead of manual input
    MKCoordinateRegion lrdRegion =MKCoordinateRegionMake(CLLocationCoordinate2DMake(27.5036, -99.5076), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:lrdRegion animated:true];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.selectedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"tagSegue" sender:nil];
    }];
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    [self.navigationController popViewControllerAnimated:true];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    PhotoAnnotation *point = [PhotoAnnotation new];
    point.coordinate = coordinate;
    point.photo = [self resizeImage:self.selectedImage withSize:CGSizeMake(50.0, 50.0)];
    [self.mapView addAnnotation:point];
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
