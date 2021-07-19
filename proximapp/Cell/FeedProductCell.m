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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setProduct:(Product *)product {
    NSLog(@"Got into product.");
    product = product;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.productLabel.text = @"Really cool item name";
    
    //TODO: upvotes, likes, support button
    
    self.priceLabel.text = @"$ 15.00";
    
    // TODO: time stamp
    // TODO: dynamic profile picture
    
    UIImage *logo = [UIImage imageNamed:@"Default_pfp.png"];
    [self.logoPic setImage:logo];
    
    PFFileObject *postImg = (PFFileObject *)[UIImage imageNamed:@"rings.png"]; // switch to image.png when returning database image
    [self.postImageView setImage:postImg];
    NSLog(@"Successfully set product.");
}

@end
