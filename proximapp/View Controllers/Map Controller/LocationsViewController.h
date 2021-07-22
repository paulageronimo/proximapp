//
//  LocationsViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/20/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LocationsViewController;

@protocol LocationsViewControllerDelegate

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@end

@interface LocationsViewController : UIViewController

@property (weak, nonatomic) id<LocationsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
