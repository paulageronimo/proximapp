//
//  FeedProductCell.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//
#import "Parse/Parse.h"
#import "Product.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoPic;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

//TODO: support button, message cell, send message button

@property (strong, nonatomic) Product *product;

@end

NS_ASSUME_NONNULL_END
