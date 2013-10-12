//
//  SLViewController.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/12/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "SLViewController.h"
#import "AppDelegate.h"

@interface SLViewController ()

//@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
//@property (strong, nonatomic) IBOutlet UITextView *textNoteOrLink;

//- (IBAction)buttonClickHandler:(id)sender;
- (void)updateView;

@end

@implementation SLViewController

//@synthesize buttonLoginLogout = _buttonLoginLogout;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self updateView];
    
    UIImage *image = [UIImage imageNamed:@"Default-568h.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view insertSubview:imageView atIndex:0];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }
}

// FBSample logic
// main helper method to update the UI to reflect the current state of the session.


- (IBAction)clickLogin:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
        [self updateView];
        }];
    }

}


- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        // [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [self performSegueWithIdentifier:@"gotoProposals" sender:self];
        
        /*[self.textNoteOrLink setText:[NSString stringWithFormat:@"https:/graph.facebook.com/me/friends?access_token=%@",
                                      appDelegate.session.accessTokenData.`accessToken]]; */
        
    } 
}

@end




