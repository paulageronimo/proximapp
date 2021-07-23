//
//  Product.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSString *prodName;
@property (nonatomic, strong) NSString *price;
//@property (nonatomic, strong) PFObject *availability;
//@property (nonatomic, strong) NSString *keywords;

//TODO: like and comment counts*

+ (void)postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )prodName withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
