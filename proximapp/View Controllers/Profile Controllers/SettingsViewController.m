//
//  SettingsViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/15/21.
//
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "SignupViewController.h"
#import "SettingsViewController.h"

@interface SettingsViewController (){
    UIActivityIndicatorView *activityIndicatorView;
}

@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *editLocationPrefButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    _editProfileButton.layer.cornerRadius = 12.0;
    _editLocationPrefButton.layer.cornerRadius = 12.0;
    _logoutButton.layer.cornerRadius = 12.0;
    
    CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    activityIndicatorView.color = [UIColor blueColor];
    [self.view addSubview:activityIndicatorView];
}

- (IBAction)onLogout:(id)sender {
    [activityIndicatorView startAnimating];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [self->activityIndicatorView stopAnimating];
        if(error){
            [self alert:error.debugDescription];
        } else {
            [self goToStartPage];
        }
    }];
    //TODO: add a button, are you sure you want to log out? if yes then log out, else cancel request
}

- (void)alert:(NSString*)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = self.view;
    UIAlertAction *Okbutton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alert addAction:Okbutton];
    popPresenter.sourceRect = self.view.frame;
    alert.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)goToStartPage {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    SignupViewController * suvc = [storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self presentViewController:suvc animated:YES completion:nil];
}

@end
