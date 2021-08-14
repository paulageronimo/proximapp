//
//  SearchProductViewController.m
//  proximapp
//
//  Created by Paula Leticia Geronimo on 7/25/21.
//

#import "SearchProductViewController.h"
#import "Parse/Parse.h"
#import "SearchProductCell.h"
#import "AppDelegate.h"
#import "Post.h"
#import "SearchDetailsViewController.h"

@interface SearchProductViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *results;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortSelector;

@end

@implementation SearchProductViewController
NSString *sortSelect;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.rowHeight = 104;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setSortType:(id)sender {
    switch(((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            sortSelect = @"Keywords";
            break;
        case 1:
            sortSelect = @"Price";
            break;
        case 2:
            sortSelect = @"Location";
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchProductCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:@"SearchProductCell"
                               forIndexPath:indexPath];
    
    NSDictionary *result = self.results[indexPath.row];
    [cell updateWithDetails:result];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *venue = self.results[indexPath.row];
    NSString *author = [venue valueForKeyPath:@"author"];
    PFGeoPoint *location = [venue valueForKeyPath:@"location"];
    PFFileObject *image = [venue valueForKeyPath:@"image"];
    NSNumber *price = [venue valueForKeyPath:@"price"];
    //[self.delegate SearchDetailsViewController:self didPick;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text
                         stringByReplacingCharactersInRange:range
                         withString:text];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fetchProducts:) object:newText];
    [self performSelector:@selector(fetchProducts:) withObject:newText afterDelay:0.5];
    
    return true;
}

- (void)fetchProducts: (NSString *)newText {
    [self fetchProductsWithQuery:newText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchProductsWithQuery:searchBar.text];
}

- (void)fetchProductsWithQuery:(NSString *)queryText {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 10;
    [query whereKey:@"prodName" containsString:[queryText lowercaseString]];
    
    if ([sortSelect isEqual: @"Location"]) {
        [query orderByAscending:@"distance"];
    } else if ([sortSelect isEqual: @"Price"]) {
        [query orderByAscending:@"price"];
    }
    
    self.results = [query findObjects];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,
                                              NSError *error) {
        if (!error) {
//            for (PFObject *object in objects) {
//              NSLog(@"%@", object[@"prodName"]);
//            }
        } else {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    [self.tableView reloadData];
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segId = [segue identifier];
    if ([segId isEqualToString:@"searchDetails"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        SearchProductViewController *detailsVC = [segue destinationViewController];
        NSDictionary *venue = self.results[indexPath.row];
        
        //detailsVC.post = post;
    } else {
        NSLog(@"Segue not recognized");
    }
}

@end
