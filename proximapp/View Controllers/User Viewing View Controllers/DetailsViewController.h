//
//  DetailsViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/24/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
