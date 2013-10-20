//
//  VoteViewController.m
//  Spokenvote
//
//  Created by Kim Miller on 10/19/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "VoteViewController.h"

@interface VoteViewController ()

@end

@implementation VoteViewController

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
    self.facebookImageView.image = self.vote.image;
    self.username.text = self.vote.username;
    self.longDate.text = self.vote.longDate;
    self.supportingComment.text = self.vote.comment;
    [self.supportingComment sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
