//
//  ProposalDetailViewController.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposalDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) NSMutableString *baseJsonURL;
@property (strong, nonatomic) NSString *proposalId;
@property (strong, nonatomic) IBOutlet UILabel *proposalStatementLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupName;
@property (strong, nonatomic) IBOutlet UILabel *formatedLocation;
@property (strong, nonatomic) IBOutlet UILabel *votesCount;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *votesArray;

@end
