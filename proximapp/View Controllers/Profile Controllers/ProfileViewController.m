//
//  ProfileViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/19/21.
//

#import "ProfileViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "User.h"
#import "PostGridCell.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pfp; // profileView
@property (weak, nonatomic) IBOutlet UIView *businessView;
@property (weak, nonatomic) IBOutlet UILabel *businessBadge;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray* posts;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *dateJoinedLabel;

@end

@implementation ProfileViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupLayout];
}

-(void) setupView {
    PFUser *currentUser = [PFUser currentUser];
    _businessBadge.layer.cornerRadius = 12.0;
    _pfp.layer.cornerRadius = 30.0;
    
    self.navBar.title = [@"@" stringByAppendingString:currentUser.username];
    self.businessView.hidden = [currentUser[@"isBusiness"] boolValue]? NO: YES;
        
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
    
    [_pfp setImage:[UIImage imageNamed:@"Default_pfp"]];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapPhoto:)];
    [_pfp addGestureRecognizer:profileTapGestureRecognizer];
    [_pfp setUserInteractionEnabled:YES];
    
    
    NSDate *date = currentUser.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    NSString *dateString = [formatter stringFromDate:date];
    
    self.dateJoinedLabel.text = [NSString stringWithFormat:@"Joined on %@", dateString];
    [self loadPosts];
    [self setupLayout];
}

-(void) setupLayout{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 0;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

-(void) loadPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" containsString:@"objectId"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = (NSMutableArray*) posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"ERROR LOADING POSTS %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [self.loadingIndicator stopAnimating];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.posts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PostGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostGridCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.row];
    return cell;
}

- (void) didTapPhoto:(UITapGestureRecognizer *)sender{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Take a Picture or Select Photo"
                                                                       message:@""
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *takePictureAction = [UIAlertAction actionWithTitle:@"Take a Picture"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            
            
        }];
        UIAlertAction *pickPictureAction = [UIAlertAction actionWithTitle:@"Select a Picture"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            
        }];
        [alert addAction:takePictureAction];
        [alert addAction:pickPictureAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    } else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
