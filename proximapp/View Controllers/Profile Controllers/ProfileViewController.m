//
//  ProfileViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addProductButton;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *pfp;
@property (weak, nonatomic) IBOutlet UIView *businessView;
@property (weak, nonatomic) IBOutlet UILabel *businessBadge;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end

@implementation ProfileViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

//TODO: add a refresh to view
-(void) setupView {
    PFUser *currentUser = [PFUser currentUser];
    
    self.navBar.title = [@"@" stringByAppendingString:currentUser.username];

    _addProductButton.layer.cornerRadius = 12.0;
    _businessBadge.layer.cornerRadius = 12.0;
    _pfp.layer.cornerRadius = 110.0;
    
    if ([currentUser[@"isBusiness"] boolValue]) {
       _businessView.hidden= NO;
   } else {
       _businessView.hidden = YES;
   }
    _username.text = currentUser[@"name"];
    //_name.text = currentUser.name;
    PFFileObject *pfp = currentUser[@"pfp"];
    [pfp getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching profile pic: %@", error.localizedDescription);
        } else {
            UIImage *pfpImg = [UIImage imageWithData:data];
            [self.pfp setImage:pfpImg];
            self.pfp.layer.cornerRadius = self.pfp.frame.size.height/2;
        }
    }];
}

@end
