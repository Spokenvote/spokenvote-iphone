//
//  VoteViewController.h
//  Spokenvote
//
//  Created by Kim Miller on 10/19/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vote.h"

@interface VoteViewController : UIViewController

@property (strong, nonatomic) Vote *vote;
@property (strong, nonatomic) IBOutlet UIImageView *facebookImageView;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *longDate;
@property (strong, nonatomic) IBOutlet UILabel *supportingComment;

@end
