//
//  SearchProductViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/25/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@interface SearchProductViewController : UIViewController
//
//@end

@class SearchProductViewController;

@protocol SearchProductViewControllerDelegate

- (void)searchProductViewController:(SearchProductViewController *)controller didPickItem:(NSString *)objID;

@end

@interface SearchProductViewController : UIViewController

@property (weak, nonatomic) id<SearchProductViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
