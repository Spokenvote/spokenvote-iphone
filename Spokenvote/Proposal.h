//
//  Proposal.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <Foundation/Foundation.h>

#define baseJsonURL @"http://www.spokenvote.org/proposals"

@interface Proposal : NSObject

//@property (nonatomic, strong) NSString *baseJsonURL;
@property (nonatomic, strong) NSNumber *proposal_id;
@property (nonatomic, strong) NSString *statement;
@property (nonatomic, strong) NSString *votes_percentage;
@property (nonatomic, strong) NSDictionary *hub;
@property (nonatomic, strong) NSString *short_hub;
@property (nonatomic, strong) NSNumber *votes_count;
@property (nonatomic, strong) NSNumber *votes_in_tree;
@property (nonatomic, strong) NSNumber *related_proposals_count;
@property (nonatomic, strong) NSMutableArray *votes;

// Designated Initializer
- (id) initWithId: (NSNumber *) id;
+ (id) proposalWithId:(NSNumber*) id;

@end
