//
//  Vote.h
//  Spokenvote
//
//  Created by Hai Nguyen on 10/11/13.
//  Copyright (c) 2013 Spokenvote. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vote : NSObject

// raw data from json
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *vote_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *facebook_auth;

// calulated values
@property (nonatomic, weak) UIImage *image;
@property (nonatomic, strong) NSString *shortDate;
@property (nonatomic, strong) NSString *longDate;


// Designated Initializer
- (id) initWithId: (NSNumber *) id;
+ (id) voteWithId:(NSNumber*) id;

- (NSURL *) thumbnailURL;
- (void) formattedDate;

@end

