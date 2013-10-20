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
    
    NSURL *proposalListURL = [NSURL URLWithString:@"http://www.spokenvote.org/proposals.json"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    NSError *error = nil;
    
    NSArray *proposalsArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.proposals = [NSMutableArray array];
    
    for (NSDictionary *proposalDictionary in proposalsArray) {

        Proposal *proposal = [Proposal proposalWithId:[proposalDictionary objectForKey:@"id"]];
        proposal.statement = [proposalDictionary objectForKey:@"statement"];
        proposal.votes_percentage = [proposalDictionary objectForKey:@"votes_percentage"];
       // NSLog(@"%@", proposal.votes_percentage);
        proposal.hub = [proposalDictionary objectForKey:@"hub"];
       // NSLog(@"%@", proposal.hub);
        proposal.votes_count = [proposalDictionary objectForKey:@"votes_count"];
        proposal.votes_in_tree = [proposalDictionary objectForKey:@"votes_in_tree"];
        proposal.related_proposals_count = [proposalDictionary objectForKey:@"related_proposals_count"];
        proposal.votes = [proposalDictionary objectForKey:@"votes"];
        [self.proposals addObject:proposal];
        
    }



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
    return [self.proposals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Proposal *proposal = [self.proposals objectAtIndex:indexPath.row];
    
    NSDictionary *hubDictionary = proposal.hub;
    NSString *short_hub = [hubDictionary objectForKey:@"short_hub"];
    
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", short_hub];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showProposalDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Proposal *proposal = [self.proposals objectAtIndex:indexPath.row];
        
        NSNumber *proposal_id = proposal.proposal_id;
        NSString *id_string = [NSString stringWithFormat:@"%@", proposal_id, nil];
        NSMutableString *url = [NSMutableString stringWithString:@"http://www.spokenvote.org/proposals/"];
        
        [url appendString:id_string];
        [url appendString:@".json"];
        
        ProposalDetailViewController *pdvc = (ProposalDetailViewController *)segue.destinationViewController;
        NSURL *url_to_carry = [NSURL URLWithString:url];
        pdvc.proposalURL = url_to_carry;
        
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
