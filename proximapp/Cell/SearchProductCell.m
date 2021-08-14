//
//  SearchProductCell.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/20/21.
//

#import "SearchProductCell.h"
#import "Parse.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SearchProductCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) NSDictionary *location;

@end

@implementation SearchProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateWithDetails:(NSDictionary *)post {
    self.nameLabel.text = post[@"prodName"];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.priceLabel.text = [currencyFormatter stringFromNumber:post[@"price"]];
    
    self.distanceLabel.text = post[@"location"];
}

@end
