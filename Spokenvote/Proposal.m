//
//  Proposal.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "Proposal.h"

@implementation Proposal

- (id) initWithId: (NSNumber *) id {
    self = [super init];
    if ( self ) {
        self.proposal_id = id;
    }
    
    return self;
}

+ (id) proposalWithId: (NSNumber *) id {
    return [[self alloc] initWithId:id];
}

//+ (NSString) baseJsonURL: (NSString *) {
//    return [[self alloc] NSMutableString stringWithString:@"http://www.spokenvote.org/proposals/"];
//}

@end
