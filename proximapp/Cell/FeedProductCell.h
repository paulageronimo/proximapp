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
//@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
//@property (weak, nonatomic) IBOutlet UITextField *messageCell;
//@property (weak, nonatomic) IBOutlet UIButton *sendMessage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) Product *product;

@end

NS_ASSUME_NONNULL_END
