//
//  TableViewController.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "TableViewController.h"
#import "Proposal.h"
#import "ProposalDetailViewController.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSURL *proposalListURL = [NSURL URLWithString:@"http://www.spokenvote.org/proposals.json"];
    NSMutableString *url = [NSMutableString stringWithString:baseJsonURL];
    [url appendString:@".json"];

    NSURL *proposalListURL = [NSURL URLWithString:url];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    NSError *error = nil;
    
    NSArray *proposalsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    self.filteredProposalsArray = [NSMutableArray arrayWithCapacity:[proposalsArray count]];
    
    self.proposals = [NSMutableArray array];
    
    for (NSDictionary *proposalDictionary in proposalsArray) {

        Proposal *proposal = [Proposal proposalWithId:[proposalDictionary objectForKey:@"id"]];
        proposal.statement = [proposalDictionary objectForKey:@"statement"];
        proposal.votes_percentage = [proposalDictionary objectForKey:@"votes_percentage"];
        proposal.hub = [proposalDictionary objectForKey:@"hub"];
        proposal.short_hub = [proposal.hub objectForKey:@"short_hub"];
        proposal.votes_count = [proposalDictionary objectForKey:@"votes_count"];
        proposal.votes_in_tree = [proposalDictionary objectForKey:@"votes_in_tree"];
        proposal.related_proposals_count = [proposalDictionary objectForKey:@"related_proposals_count"];
        proposal.votes = [proposalDictionary objectForKey:@"votes"];
        [self.proposals addObject:proposal];
        
    }

    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredProposalsArray count];
    } else {
        return [self.proposals count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Proposal *proposal;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        proposal = [self.filteredProposalsArray objectAtIndex:indexPath.row];
    } else {
        proposal = [self.proposals objectAtIndex:indexPath.row];
    }
    
    
    //proposal.votes_percentage
    
    UILabel *votesInTree = (UILabel *)[cell viewWithTag:1];
    votesInTree.text = [NSString stringWithFormat:@"%@", proposal.votes_in_tree, nil];
    
    UILabel *relatedProposalsCount = (UILabel *)[cell viewWithTag:2];
    relatedProposalsCount.text = [NSString stringWithFormat:@"%@", proposal.related_proposals_count, nil];

    UILabel *votesLabel = (UILabel *)[cell viewWithTag:3];
    [votesLabel.layer setCornerRadius:3];
    
    UILabel *propsLabel = (UILabel *)[cell viewWithTag:4];
    [propsLabel.layer setCornerRadius:3];
    //    relatedProposalsCount.text = [NSString stringWithFormat:@"%@", proposal.related_proposals_count, nil];
    

    cell.textLabel.text = proposal.statement;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", proposal.short_hub];
    
    return cell;
}


/*#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"showProposalDetail" sender:tableView];
} */

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    //tableView == self.searchDisplayController.searchResultsTableView
    
    if ( [segue.identifier isEqualToString:@"showProposalDetail"]){
        NSIndexPath *indexPath;
        Proposal *proposal;
        if([self.searchDisplayController isActive]) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            proposal = [self.filteredProposalsArray objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            proposal = [self.proposals objectAtIndex:indexPath.row];
        }
        NSNumber *proposal_id = proposal.proposal_id;
        NSString *id_string = [NSString stringWithFormat:@"%@", proposal_id, nil];

        ProposalDetailViewController *pdvc = (ProposalDetailViewController *)segue.destinationViewController;
        pdvc.proposalId = id_string;

//        NSMutableString *url = [NSMutableString stringWithString:@"http://www.spokenvote.org/proposals/"];
        
//        [url appendString:id_string];
//        [url appendString:@".json"];
        
//        NSURL *url_to_carry = [NSURL URLWithString:url];
//        pdvc.proposalURL = url_to_carry;
    }
    
}


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredProposalsArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.statement contains[c] %@",searchText];
    self.filteredProposalsArray = [NSMutableArray arrayWithArray:[self.proposals filteredArrayUsingPredicate:predicate]];
    
    if (![scope isEqualToString:@"Proposal"]) {
        // Further filter the array with the scope
        //NSString *groupName = [hub objectForKey:@"group_name"];
        predicate = [NSPredicate predicateWithFormat:@"SELF.short_hub contains[c] %@",searchText];
        self.filteredProposalsArray = [NSMutableArray arrayWithArray:[self.proposals filteredArrayUsingPredicate:predicate]];
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 97;
    
}
@end
