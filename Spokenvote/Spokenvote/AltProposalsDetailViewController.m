//
//  AltProposalsDetailViewController.m
//  Spokenvote
//
//  Created by Kim Miller on 10/20/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "AltProposalsDetailViewController.h"
#import "ProposalDetailViewController.h"
#import "Proposal.h"
#import "Vote.h"
#import "VoteViewController.h"

@interface AltProposalsDetailViewController ()

@end

@implementation AltProposalsDetailViewController

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
	// Do any additional setup after loading the view.
    
    NSMutableString *url = [NSMutableString stringWithString:baseJsonURL];
    
    [url appendString:@"/"];
    [url appendString:self.proposalId];
    [url appendString:@"/related_proposals.json"];
    
    NSURL *proposalListURL = [NSURL URLWithString:url];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    NSError *error = nil;
    
    NSDictionary *alternateProposals = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//    NSDictionary *proposalDetail = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    for (NSDictionary *alternateProposalDictionary in [alternateProposals objectForKey:@"related_proposals"] ) {
        Proposal *alternateProposal = [Proposal proposalWithId:[alternateProposalDictionary objectForKey:@"id"]];
        alternateProposal.statement = [alternateProposalDictionary objectForKey:@"statement"];
        alternateProposal.hub = [alternateProposalDictionary objectForKey:@"hub"];
        alternateProposal.votes_count = [alternateProposalDictionary objectForKey:@"votes_count"];
        alternateProposal.votes = [alternateProposalDictionary objectForKey:@"votes"]; // an array of dictionary, which represents a vote
        
        self.proposalStatementLabel.text = alternateProposal.statement;
        self.groupName.text = [alternateProposal.hub objectForKey:@"group_name"];
        self.formatedLocation.text = [alternateProposal.hub objectForKey:@"formatted_location"];
        
        NSMutableString *votesCountString = [NSMutableString stringWithString:@"("];
        NSString *votesNum = [NSString stringWithFormat:@"%@", alternateProposal.votes_count, nil];
        [votesCountString appendString:votesNum];
        [votesCountString appendString:@" Votes)"];
        
        self.votesCount.text = votesCountString;
        
        // Set up array of Vote objects
        self.votesArray = [NSMutableArray array];
        for (NSDictionary *voteDictionary in alternateProposal.votes) {
            
            Vote *vote = [Vote voteWithId:[voteDictionary objectForKey:@"id"]];
            vote.comment = [voteDictionary objectForKey:@"comment"];
            vote.username = [voteDictionary objectForKey:@"username"];
            vote.created_at = [voteDictionary objectForKey:@"created_at"];
            vote.facebook_auth = [voteDictionary objectForKey:@"facebook_auth"];
            
            [self.votesArray addObject:vote];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
