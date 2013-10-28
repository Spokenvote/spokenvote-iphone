//
//  ProposalDetailViewController.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposalDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *proposalId;
@property (strong, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) IBOutlet UILabel *proposalStatement;
@property (strong, nonatomic) IBOutlet UILabel *formatedLocation;

// Outlets and Properties for supportTableView (aka. tableView)
@property (strong, nonatomic) IBOutlet UITableView *supportTableView;
@property (strong, nonatomic) IBOutlet UILabel *votesCount;
@property (strong, nonatomic) NSMutableArray *votesArray;

// Outlet for alternateTableView
@property (strong, nonatomic) IBOutlet UITableView *alternateTableView;
@property (strong, nonatomic) NSMutableArray *alternateProposals;

- (IBAction)toggleControls:(UISegmentedControl *)sender;

@end
