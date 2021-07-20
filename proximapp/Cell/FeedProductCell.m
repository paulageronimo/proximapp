//
//  FeedProductCell.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "FeedProductCell.h"
#import "Product.h"
#import "Parse/Parse.h"
#import "UploadViewController.h"

@implementation FeedProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setupView {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setProduct:(Product *)product {
    NSLog(@"Got into product.");
    product = product;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.productLabel.text = product[@"prodName"];
    
    //TODO: upvotes, likes, support button
    
    self.priceLabel.text = product[@"price"];
    
    // TODO: time stamp
    self.timeLabel.text = product[@""];
    // TODO: dynamic profile picture
    
    UIImage *logo = [UIImage imageNamed:@"pfp.png"];
    [self.logoPic setImage:logo];
    
    UIImage *postImg = [UIImage imageNamed:@"image.png"];
    [self.postImageView setImage:postImg];
    NSLog(@"Successfully set product.");
}

@end
