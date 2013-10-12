//
//  ProposalDetailViewController.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposalDetailViewController : UIViewController

@property (strong, nonatomic) NSURL *proposalURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
