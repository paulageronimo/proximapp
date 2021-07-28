//
//  Post.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//

#import "Post.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic prodName;
@dynamic image;
@dynamic price;
@dynamic availability;
@dynamic keywords;
@dynamic logo;
//@dynamic likeCount;
//@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
