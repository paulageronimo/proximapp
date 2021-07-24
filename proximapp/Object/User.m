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
@dynamic location;
//@dynamic

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

+(BOOL) changeProfileType:(NSNumber *)isOnOrOff forUser:(User *)user completion: (PFBooleanResultBlock _Nullable)completion {
    if (isOnOrOff) {
        user.isBusiness = (PFObject *)@YES;
        [user saveInBackgroundWithBlock:completion];
    } else {
        user.isBusiness = (PFObject *)@NO;
        [user saveInBackgroundWithBlock:completion];
    }
    return nil;
}

@end
