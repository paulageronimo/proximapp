//
//  Product.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "Product.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"

@implementation Product 

@dynamic productID;
@dynamic userID;
@dynamic author;
@dynamic prodName;
@dynamic image;
@dynamic logo;
//@dynamic likeCount;
//@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Product";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Product *newProduct = [Product new];
    newProduct.image = [self getPFFileFromImage:image];
    newProduct.author = [PFUser currentUser];
    //newProduct.prodName = prodName;
    //newProduct.likeCount = @(0);
    //newProduct.commentCount = @(0);
    
    [newProduct saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    //PFFile vs PFFileObject
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
