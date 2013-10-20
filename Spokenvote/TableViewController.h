//
//  TableViewController.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface TableViewController : UITableViewController
@interface TableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSMutableArray *filteredProposalsArray;

@property (strong, nonatomic) NSMutableArray *proposals;
@property (strong, nonatomic) IBOutlet UISearchBar *proposalSearchBar;

@end
