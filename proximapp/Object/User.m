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

+ (void) changeUserPfp:(User *)user withPfp:(UIImage *)pfp completion:(PFBooleanResultBlock)completion {
    user.pfp = [self getPFFileFromImage:pfp];
    [user saveInBackgroundWithBlock:completion];
}

+ (PFFileObject *) getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

#pragma mark - helper functions

+ (void)alert: (NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notification"
    message:errorMessage
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    //[self presentViewController:alert animated:YES completion:^{}];
}

@end
