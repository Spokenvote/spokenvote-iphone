//
//  AltProposalsDetailViewController.h
//  Spokenvote
//
//  Created by Kim Miller on 10/20/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AltProposalsDetailViewController : UIViewController

//@property (strong, nonatomic) NSURL *proposalURL;
@property (strong, nonatomic) NSString *proposalId;
@property (strong, nonatomic) IBOutlet UILabel *proposalStatementLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) IBOutlet UILabel *formatedLocation;
@property (strong, nonatomic) IBOutlet UILabel *votesCount;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *votesArray;


@end
