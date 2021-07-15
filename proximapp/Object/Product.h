//
//  Product.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "PFObject.h"
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *prodName;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) PFFileObject *logo;
//@property (nonatomic, strong) NSNumber *likeCount;
//@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
