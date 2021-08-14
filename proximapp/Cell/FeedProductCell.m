//
//  FeedProductCell.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "FeedProductCell.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "DateTools.h"

@implementation FeedProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

- (void)setupView {
    _postImageView.layer.cornerRadius = 12.0;
    _priceLabel.layer.cornerRadius = 12.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPost:(Post *)post {
    NSLog(@"Got into product.");
    post = post;
    //TODO: upvotes, likes, support button
    
    // TODO: dynamic profile picture
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.productLabel.text = post[@"prodName"];
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.priceLabel.text = [currencyFormatter stringFromNumber:post[@"price"]];
    
    self.timeLabel.text = [post.createdAt timeAgoSinceNow];
    
    PFFileObject *img = post[@"image"];
    [img getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            UIImage *postImg = [UIImage imageWithData:data];
            [self.postImageView setImage:postImg];
        }
    }];
}

@end
