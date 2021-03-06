//
//  ViewController.m
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import "AcronymTableViewController.h"
#import "AcromineRequest.h"
#import "AcromineResult.h"
#import "MBProgressHUD.h"

@implementation AcronymTableViewController

// String Constants
NSString *const NoResults = @"No results found";
NSString *const Prompt = @"Please enter an acronym or initialism";
NSString *const RestService = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=";

// Record last search, used for verifying results returned from REST Service match query
NSString *lastSearch;

// MARK: View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.title = @"Acronym Lookup";
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = Prompt;
}

// MARK: API Request

- (void) makeAcromineRequest:(NSString *)url{
    AcromineRequest *request = [AcromineRequest alloc];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [request fetch:url:^(NSArray *results) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // ensure the results match the last search
        if(self.searchBar.text != lastSearch){
            return;
        }
        
        // update data source
        self.listItems = results;
        
        // set search text to "no results" if none were returned
        if(self.listItems.count == 0){
            self.searchBar.text = nil;
            self.searchBar.placeholder = NoResults;
        }
        
        [self.tableView reloadData];
    }];
}

// MARK: Table Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return self.listItems.count; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((AcromineResult *)self.listItems[section]).variations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    AcromineResult *result = ((AcromineResult *)[self.listItems objectAtIndex:indexPath.section]).variations[indexPath.row];
    cell.textLabel.text = result.description;

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return ((AcromineResult *)self.listItems[section]).description;
}


// MARK: Search Bar Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // ignore searches if the user hasn't entered any text
    if(searchBar.text == Prompt || searchBar.text == NoResults || searchBar.text == nil){
        return;
    }

    lastSearch = self.searchBar.text;
    
    // url encode search
    NSString *search = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [self makeAcromineRequest:[NSString stringWithFormat:@"%@%@", RestService, search]];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBar.placeholder = Prompt;
}

// MARK: Tap Handler

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    // hide the keyboard when the user clicks outside of the search area
    [self.searchBar resignFirstResponder];
}


@end
