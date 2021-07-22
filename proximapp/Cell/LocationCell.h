//
//  LocationCellTableViewCell.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationCell : UITableViewCell

- (void)updateWithLocation:(NSDictionary *)location;

@end

NS_ASSUME_NONNULL_END
