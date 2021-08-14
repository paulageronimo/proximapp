//
//  SearchDetailsViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 8/11/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@class SearchDetailsViewController;

@protocol SearchDetailsViewControllerDelegate

- (void)SearchDetailsViewController:(SearchDetailsViewController *)controller didPickIemWithLocation: (PFGeoPoint *)location author:(NSString *)author img:(PFFileObject *)image price:(NSNumber *)price;

@end

@interface SearchDetailsViewController : UIViewController

@property (weak, nonatomic) id<SearchDetailsViewControllerDelegate> delegate;
@property (strong, nonatomic) Post *post;

@end
NS_ASSUME_NONNULL_END
