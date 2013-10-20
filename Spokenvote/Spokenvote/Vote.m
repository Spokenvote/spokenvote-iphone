//
//  Vote.m
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import "Vote.h"

@implementation Vote

- (id) initWithId: (NSNumber *) id {
    self = [super init];
    if ( self ) {
        self.vote_id = id;
    }
    
    return self;
}

+ (id) voteWithId: (NSNumber *) id {
    return [[self alloc] initWithId:id];
}

@end
