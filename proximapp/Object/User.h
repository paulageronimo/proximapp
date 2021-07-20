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
@property (nonatomic, strong) PFObject *name;
@property (nonatomic, strong) PFObject *isBusiness;

+(void) changeUserPfp: (User *)user withPfp:(UIImage * _Nullable)pfp completion: (PFBooleanResultBlock _Nullable)completion;

+(BOOL) changeProfileType: (User *)user completion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
