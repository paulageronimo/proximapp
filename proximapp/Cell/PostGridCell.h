//
//  PostGridCell.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 8/5/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostGridCell : UICollectionViewCell
@property (strong, nonatomic) Post *post;
@property (nonatomic) CGSize postSize;

@end

NS_ASSUME_NONNULL_END
