//
//  firstScreenViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/24/21.
//

#import "firstScreenViewController.h"
#import "BackgroundVideo.h"

@interface firstScreenViewController ()
@property (strong, nonatomic) BackgroundVideo *backgroundVideo;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation firstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundVideo = [[BackgroundVideo alloc] initOnViewController:self withVideoURL:@"login-video.mp4"];
    [self.backgroundVideo setUpBackground];
    _signupButton.layer.cornerRadius = 12.0;
    _loginButton.layer.cornerRadius = 12.0;
}

@end
