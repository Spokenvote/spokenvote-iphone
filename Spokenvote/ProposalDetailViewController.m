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
    
    // Construct url; for proposalID = 84, we have http://www.spokenvote.org/proposals/84.json
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
    
    // Set text value for Label outlets
    self.proposalStatement.text = proposal.statement;
    self.groupName.text = [proposal.hub objectForKey:@"group_name"];
    self.formatedLocation.text = [proposal.hub objectForKey:@"formatted_location"];
    self.votesCount.text = [NSString stringWithFormat:@"%@ Votes", proposal.votes_count];

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
    [self setUpAlternateTableView];
}

- (void) setUpAlternateTableView
{
    self.alternateTableView.rowHeight = 90;
    self.alternateProposals = [NSMutableArray array];
    // Construct url; for proposalID = 84, we have http://www.spokenvote.org/proposals/84.json
    NSMutableString *url = [NSMutableString stringWithString:baseJsonURL];
    
    [url appendString:@"/"];
    [url appendString:self.proposalId];
    [url appendString:@"/related_proposals.json"];
    
    NSURL *proposalListURL = [NSURL URLWithString:url];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    NSError *error = nil;
    
    NSDictionary *alternateDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    // value for "related_proposals" key is an array of dictionaries
    for (NSDictionary *alternateProposalDictionary in [alternateDictionary objectForKey:@"related_proposals"]) {
        
        Proposal *alternateProposal = [Proposal proposalWithId:[alternateProposalDictionary objectForKey:@"id"]];
        alternateProposal.statement = [alternateProposalDictionary objectForKey:@"statement"];
        alternateProposal.hub = [alternateProposalDictionary objectForKey:@"hub"];
        alternateProposal.user = [alternateProposalDictionary objectForKey:@"user"];
        alternateProposal.votes_count = [alternateProposalDictionary objectForKey:@"votes_count"];
        // votes is an array of dictionaries, each dictionary is a vote
        alternateProposal.votes = [alternateProposalDictionary objectForKey:@"votes"];
        [self.alternateProposals addObject:alternateProposal];
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
    if ([tableView isEqual:self.supportTableView]) {
        return [self.votesArray count];
    } else {
        return [self.alternateProposals count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([tableView isEqual:self.supportTableView]) {
    
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
    } else {
        Proposal *alternateProposal = [self.alternateProposals objectAtIndex:indexPath.row];
        cell.textLabel.text = alternateProposal.statement;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Votes",alternateProposal.votes_count];
    }
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showVote"]){
        NSIndexPath *indexPath = [self.supportTableView indexPathForSelectedRow];
        Vote *vote = [self.votesArray objectAtIndex:indexPath.row];
        
        VoteViewController *voteViewController = (VoteViewController *)segue.destinationViewController;
        voteViewController.vote = vote;
    }
    
    if ( [segue.identifier isEqualToString:@"showAlternateProposal"]){
        NSIndexPath *indexPath = [self.alternateTableView indexPathForSelectedRow];
        Proposal *proposal =  [self.alternateProposals objectAtIndex:indexPath.row];
        NSNumber *proposal_id = proposal.proposal_id;
        NSString *id_string = [NSString stringWithFormat:@"%@", proposal_id, nil];
        
        ProposalDetailViewController *pdvc = (ProposalDetailViewController *)segue.destinationViewController;
        pdvc.proposalId = id_string;
    } 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.alternateTableView.hidden = YES;
        self.supportTableView.hidden = NO;
    } else {
        self.supportTableView.hidden = YES;
        self.alternateTableView.hidden = NO;
    }
}
@end
