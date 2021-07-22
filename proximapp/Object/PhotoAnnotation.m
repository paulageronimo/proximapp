//
//  PhotoAnnotation.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/22/21.
//

#import "PhotoAnnotation.h"
#import "Parse/Parse.h"

@interface PhotoAnnotation()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PhotoAnnotation

- (NSString *)title {
    //PFObject *currentProduct = [PFObject productName];
    return [NSString stringWithFormat:@"%f", self.coordinate.latitude];
}

@end
