//
//  SignupViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/14/21.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignupViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@end

NS_ASSUME_NONNULL_END
