//
//  EditProfileViewController.h
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *profileTypeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *profileTypeLabel;

@end

NS_ASSUME_NONNULL_END
