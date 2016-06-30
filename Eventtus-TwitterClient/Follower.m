//
//  Follower.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "Follower.h"

@implementation Follower

-(Follower *) initWithDictionary:(NSDictionary *)json {
    
    self = [super init];
    
    self.followerDescription = [json objectForKey:@"description"];
    self.followerID = [json objectForKey:@"id_str"];
    self.followerName = [json objectForKey:@"screen_name"];
    self.followerScreenName = [json objectForKey:@"name"];
    
    return self;
}

@end
