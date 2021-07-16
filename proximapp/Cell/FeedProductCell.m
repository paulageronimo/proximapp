//
//  FeedProductCell.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "FeedProductCell.h"
#import "Product.h"
#import "Parse/Parse.h"

@implementation FeedProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setProduct:(Product *)product {
    NSLog(@"Got into product.");
    product = product;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // PFUser *user = product[@"author"];
//    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
//        self.usernameLabel.text =  user[@"username"];
//    }];
    self.productLabel.text = @"Really cool item name";
    //self.productLabel.text = product[@"prodName"];
    // setup timestamp
//    self.likesLabel.text = [[NSString stringWithFormat:@"%@", product.likeCount] stringByAppendingString:@" likes"];
//
    //self.timeLabel.text = [product.createdAt timeAgoSinceNow];
    self.priceLabel.text = @"$ 15.00";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [[formatter stringFromDate:self.product.createdAt] stringByReplacingOccurrencesOfString:@", " withString:@" \u2022 "];

//    PFFileObject *logoPic = (PFFileObject*)[UIImage imageNamed:@"Default_pfp.png"];
//    [logoPic getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error fetching logo pic: %@", error.localizedDescription);
//        } else {
//            UIImage *logo = [UIImage imageWithData:data];
//                [self.logoPic setImage:logo];
//        }
//    }];
    UIImage *logo = [UIImage imageNamed:@"Default_pfp.png"];
    [self.logoPic setImage:logo];
    
//    PFFileObject *image = product[@"image"];
//    [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error getting image: %@", error.localizedDescription);
//        } else {
//            NSLog(@"Got image and producted");
//            //NSURL * imageURL = [NSURL URLWithString:image.url];
//            //[self.productImageView setImageWithURL:imageURL];
//            UIImage *productImg = [UIImage imageWithData:data];
//            [self.postImageView setImage:productImg];
//
////            - PFFileObject * image = user[@"profile_image"]; // set your column name from Parse here
////            - NSURL * imageURL = [NSURL URLWithString:profileImage.url];
////            - [self.profileImageView setImageWithURL:imageURL];
//        }
//    }];
    UIImage *postImg = [UIImage imageNamed:@"Image.png"];
    [self.product setImage:postImg];
    
    
}

@end
