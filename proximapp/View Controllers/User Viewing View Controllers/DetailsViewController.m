//
//  DetailsViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/24/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import <Parse/Parse.h>
#import "LocationsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *productLabel; //prodName
//@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIView *cardItemView;
@property (weak, nonatomic) IBOutlet UIButton *visitButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    //[self setupMapView];
}

- (void)setupView {
    _cardItemView.layer.cornerRadius = 12.0;
    _productLabel.layer.cornerRadius = 12.0;
    _priceLabel.layer.cornerRadius = 12.0;
    _logoView.layer.cornerRadius = 12.0;
    _visitButton.layer.cornerRadius = 12.0;
    _pictureView.layer.cornerRadius = 12.0;
    
    self.navBar.title = [@"Post by @" stringByAppendingString:self.post.author.username];

    self.productLabel.text = self.post.prodName;
    self.priceLabel.text = self.post.price;
    // setup image
    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            UIImage *postImg = [UIImage imageWithData:data];
            [self.pictureView setImage:postImg];
        }
    }];
    //TODO: set up user's logo
//    PFUser *currentUser = self.post.author;
//    self.logoView = currentUser.pfp;
    
}


@end
