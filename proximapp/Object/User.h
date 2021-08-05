//
//  User.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "PFUser.h"
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface User : PFUser <PFSubclassing>

@property (nonatomic, strong) PFFileObject *pfp;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PFObject *isBusiness;
@property (nonatomic, strong) PFGeoPoint *location;
 
+ (void) changeUserPfp: (User *)user withPfp:(UIImage * _Nullable)pfp completion: (PFBooleanResultBlock _Nullable)completion;

+ (void)alert: (NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END
