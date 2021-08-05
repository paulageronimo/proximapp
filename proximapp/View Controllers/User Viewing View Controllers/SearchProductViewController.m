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


@interface SearchProductViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *results;

@end

@implementation SearchProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    //[self fetchProductsWithQuery: productName:];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setSortType:(id)sender {
    switch(((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            // TODO: Sort type by keywords
            break;
        case 1:
            // TODO: Sort type by price
            break;
        case 2:
            // TODO: Sort type by location from user
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
    NSString *objID = [venue valueForKeyPath:@"objectID"];
    [self.delegate searchProductViewController:self didPickItem:objID];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text
                         stringByReplacingCharactersInRange:range
                         withString:text];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fetchProducts:) object:newText];
    [self performSelector:@selector(fetchProducts:) withObject:newText afterDelay:5.0];
    
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
    
    self.results = [query findObjects];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,
                                              NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
              NSLog(@"%@", object[@"prodName"]);
            }
        } else {
             NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    [self.tableView reloadData];
}


@end
