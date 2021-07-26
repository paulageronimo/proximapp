//
//  PhotoAnnotation.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/22/21.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@import MapKit;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAnnotation : NSObject <MKAnnotation> {
    UIImage *photo;
    NSString *title;
    NSString *Subtitle;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) UIImage *photo;

@end

NS_ASSUME_NONNULL_END
