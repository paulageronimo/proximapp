//
//  MapViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/20/21.
//

#import "LocationsViewController.h"
#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
     MKAnnotationView *annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
     if (annotationView == nil) {
         annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
         annotationView.canShowCallout = true;
         annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
     }

     UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
     //imageView.image = [UIImage imageNamed:@"camera-icon"];
    
    PhotoAnnotation *photoAnnotationItem = annotation; // refer to this generic annotation as our more specific PhotoAnnotation
    imageView.image = photoAnnotationItem.photo; // set the image into the callout imageview
    annotationView.image = photoAnnotationItem.photo;
    return annotationView;
 }

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    [self.navigationController popViewControllerAnimated:true];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    PhotoAnnotation *point = [PhotoAnnotation new];
    point.coordinate = coordinate;
    point.photo = [self resizeImage:self.selectedImage withSize:CGSizeMake(50.0, 50.0)];
    [self.mapView addAnnotation:point];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
