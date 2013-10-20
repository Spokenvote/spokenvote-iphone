//
//  AltProposalsDetailViewController.m
//  Spokenvote
//
//  Created by Kim Miller on 10/20/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "AltProposalsDetailViewController.h"

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

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//    
//    NSURL *proposalListURL = self.proposalURL;
//    
//    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
//
//    
//    NSError *error = nil;
//    
//    NSDictionary *proposalDetail = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//    
//    
//    Proposal *proposal = [Proposal proposalWithId:[proposalDetail objectForKey:@"id"]];
//    proposal.statement = [proposalDetail objectForKey:@"statement"];
//    proposal.hub = [proposalDetail objectForKey:@"hub"];
//    proposal.votes_count = [proposalDetail objectForKey:@"votes_count"];
//    proposal.votes = [proposalDetail objectForKey:@"votes"]; // an array of dictionary, which represents a vote
//    
//    self.proposalStatementLabel.text = proposal.statement;
//    self.groupName.text = [proposal.hub objectForKey:@"group_name"];
//    self.formatedLocation.text = [proposal.hub objectForKey:@"formatted_location"];
//    
//    NSMutableString *votesCountString = [NSMutableString stringWithString:@"("];
//    NSString *votesNum = [NSString stringWithFormat:@"%@", proposal.votes_count, nil];
//    [votesCountString appendString:votesNum];
//    [votesCountString appendString:@" Votes)"];
//    
//    self.votesCount.text = votesCountString;
//    
//    // Set up array of Vote objects
//    self.votesArray = [NSMutableArray array];
//    for (NSDictionary *voteDictionary in proposal.votes) {
//        
//        Vote *vote = [Vote voteWithId:[voteDictionary objectForKey:@"id"]];
//        vote.comment = [voteDictionary objectForKey:@"comment"];
//        vote.username = [voteDictionary objectForKey:@"username"];
//        vote.created_at = [voteDictionary objectForKey:@"created_at"];
//        vote.facebook_auth = [voteDictionary objectForKey:@"facebook_auth"];
//        
//        [self.votesArray addObject:vote];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
