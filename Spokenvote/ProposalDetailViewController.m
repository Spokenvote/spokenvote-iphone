//
//  ProposalDetailViewController.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "ProposalDetailViewController.h"
#import "Proposal.h"
#import "Vote.h"
#import "VoteViewController.h"

@interface ProposalDetailViewController ()

@end

@implementation ProposalDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSMutableString *url = [NSMutableString stringWithString:baseJsonURL];
    
    [url appendString:@"/"];
    [url appendString:self.proposalId];
    [url appendString:@".json"];
    
    NSURL *proposalListURL = [NSURL URLWithString:url];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    NSError *error = nil;
    
    NSDictionary *proposalDetail = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    Proposal *proposal = [Proposal proposalWithId:[proposalDetail objectForKey:@"id"]];
    proposal.statement = [proposalDetail objectForKey:@"statement"];
    proposal.hub = [proposalDetail objectForKey:@"hub"];
    proposal.votes_count = [proposalDetail objectForKey:@"votes_count"];
    proposal.votes = [proposalDetail objectForKey:@"votes"]; // an array of dictionary, which represents a vote
    
    self.proposalStatementLabel.text = proposal.statement;
    self.groupName.text = [proposal.hub objectForKey:@"group_name"];
    self.formatedLocation.text = [proposal.hub objectForKey:@"formatted_location"];
    
    NSMutableString *votesCountString = [NSMutableString stringWithString:@"("];
    NSString *votesNum = [NSString stringWithFormat:@"%@", proposal.votes_count, nil];
    [votesCountString appendString:votesNum];
    [votesCountString appendString:@" Votes)"];

    self.votesCount.text = votesCountString;

    // Set up array of Vote objects
    self.votesArray = [NSMutableArray array];
    for (NSDictionary *voteDictionary in proposal.votes) {
        
        Vote *vote = [Vote voteWithId:[voteDictionary objectForKey:@"id"]];
        vote.comment = [voteDictionary objectForKey:@"comment"];
        vote.username = [voteDictionary objectForKey:@"username"];
        vote.created_at = [voteDictionary objectForKey:@"created_at"];
        vote.facebook_auth = [voteDictionary objectForKey:@"facebook_auth"];
        
        [self.votesArray addObject:vote];
    }
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
    return [self.votesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Vote *vote = [self.votesArray objectAtIndex:indexPath.row];
    
    UILabel *created_at = (UILabel *)[cell viewWithTag:1];
    [vote formattedDate];
    created_at.text = vote.shortDate;
    
    if ( [vote.facebook_auth isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:vote.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        vote.image = image;
    } else {
        vote.image = [UIImage imageNamed:@"action-people.png"];
    }
    cell.imageView.image = vote.image;
    cell.textLabel.text = vote.username;
    cell.detailTextLabel.text = vote.comment;
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showVote"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Vote *vote = [self.votesArray objectAtIndex:indexPath.row];
        
        VoteViewController *voteViewController = (VoteViewController *)segue.destinationViewController;
        voteViewController.vote = vote;
    }
    
    /*if ( [segue.identifier isEqualToString:@"showAlternateProposal"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Proposal *proposal =  [self.proposals objectAtIndex:indexPath.row];
        NSNumber *proposal_id = proposal.proposal_id;
        NSString *id_string = [NSString stringWithFormat:@"%@", proposal_id, nil];
        
        ProposalDetailViewController *pdvc = (ProposalDetailViewController *)segue.destinationViewController;
        pdvc.proposalId = id_string;
        
        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Proposal *proposal = [self.votesArray objectAtIndex:indexPath.row];
//        
//        VoteViewController *voteViewController = (VoteViewController *)segue.destinationViewController;
//        voteViewController.vote = vote;
    } */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.alternateTableView.hidden = YES;
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
        self.alternateTableView.hidden = NO;
    }
}
@end
