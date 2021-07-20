//
//  ProfileViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addProductButton;
//@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *pfp;
@property (weak, nonatomic) IBOutlet UIView *businessView;
@property (weak, nonatomic) IBOutlet UILabel *businessBadge;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

//TODO: add a refresh to view
-(void) setupView {
    _addProductButton.layer.cornerRadius = 12.0;
    _businessBadge.layer.cornerRadius = 12.0;
   PFUser *currentUser = [PFUser currentUser];
    
    if ([currentUser[@"isBusiness"]  isEqual: @YES]) {
       _businessView.hidden=NO;
   } else {
       _businessView.hidden = YES;
   }
    _username.text = [NSString stringWithFormat:@"@%@", currentUser.username];
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
