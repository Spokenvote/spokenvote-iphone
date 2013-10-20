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


- (NSURL *) thumbnailURL {
    //    NSLog(@"%@",[self.thumbnail class]);
    // graph.facebook.com/1013711516/picture
    NSMutableString *pictureString = [NSMutableString stringWithString:@"https://graph.facebook.com/"];
    
    
    [pictureString appendString:self.facebook_auth];
    [pictureString appendString:@"/picture"];
    return [NSURL URLWithString:pictureString];
}

- (void) formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]; //2013-10-04T03:59:38Z
    NSDate *tempDate = [dateFormatter dateFromString:self.created_at];
    
    [dateFormatter setDateFormat:@"EE MMM,dd"];
    self.shortDate = [dateFormatter stringFromDate:tempDate];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    self.longDate = [dateFormatter stringFromDate:tempDate];
}

@end
