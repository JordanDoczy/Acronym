//
//  ViewController.h
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcronymTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong) NSArray *listItems;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end