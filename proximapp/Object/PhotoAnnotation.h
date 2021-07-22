//
//  PhotoAnnotation.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/22/21.
//

#import <Foundation/Foundation.h>
@import MapKit;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) UIImage *photo;

@end

NS_ASSUME_NONNULL_END
