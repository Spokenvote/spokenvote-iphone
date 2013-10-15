//
//  Proposal.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proposal : NSObject

@property (nonatomic, strong) NSNumber *proposal_id;
@property (nonatomic, strong) NSString *statement;
@property (nonatomic, strong) NSString *votes_percentage;
@property (nonatomic, strong) NSDictionary *hub;
@property (nonatomic, strong) NSNumber *votes_count;
@property (nonatomic, strong) NSMutableArray *votes;

// Designated Initializer
- (id) initWithId: (NSNumber *) id;
+ (id) proposalWithId:(NSNumber*) id;

@end
