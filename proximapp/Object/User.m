//
//  User.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "User.h"

@implementation User
@dynamic pfp;
@dynamic isBusiness;
@dynamic name;

+(void) changeUserPfp:(User *)user withPfp:(UIImage *)pfp completion:(PFBooleanResultBlock)completion {
    user.pfp = [self getPFFileFromImage:pfp];
    [user saveInBackgroundWithBlock:completion];
}

+(PFFileObject *) getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

+(BOOL) changeProfileType: (User *)user completion: (PFBooleanResultBlock _Nullable)completion {
    // ??
    if (YES) {
        user.isBusiness = (PFObject *)@YES;
        [user saveInBackgroundWithBlock:completion];
    } else {
        user.isBusiness = (PFObject *)@NO;
        [user saveInBackgroundWithBlock:completion];
    }
    return nil;
}

@end
