//
//  ProposalDetailViewController.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "ProposalDetailViewController.h"
#import "Proposal.h"

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
    
    NSURL *proposalListURL = self.proposalURL;
    
    NSData *jsonData = [NSData dataWithContentsOfURL:proposalListURL];
    
    
    NSError *error = nil;
    
    NSDictionary *proposalDetail = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
//    NSLog(@"%@",proposalDetail);
    
    Proposal *proposal = [Proposal proposalWithId:[proposalDetail objectForKey:@"id"]];
    proposal.statement = [proposalDetail objectForKey:@"statement"];
    proposal.hub = [proposalDetail objectForKey:@"hub"];
    
    self.proposalStatementLabel.text = proposal.statement;
    self.groupName.text = [proposal.hub objectForKey:@"group_name"];
    self.formatedLocation.text = [proposal.hub objectForKey:@"formatted_location"];

    
    NSLog(@"%@",proposal.statement);

//        proposal.votes_percentage = [proposalDictionary objectForKey:@"votes_percentage"];
//        // NSLog(@"%@", proposal.votes_percentage);
//        proposal.hub = [proposalDictionary objectForKey:@"hub"];
        // NSLog(@"%@", proposal.hub);
//        proposal.votes_count = [proposalDictionary objectForKey:@"votes_count"];
//        proposal.votes = [proposalDictionary objectForKey:@"votes"];
//        [self.proposals addObject:proposal];
    
    
//	[self.webView loadRequest:urlRequest];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
