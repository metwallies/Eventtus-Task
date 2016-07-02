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
    self.BGImage = [ json objectForKey:@"profile_background_image_url_https"];
    self.image = [json objectForKey:@"profile_image_url_https"];
    return self;
}


-(Follower *) initWithDictFromCache:(NSDictionary *)json {
    
    self = [super init];
    
    self.followerDescription = [json objectForKey:@"followerDesc"];
    self.followerID = [json objectForKey:@"followerID"];
    self.followerName = [json objectForKey:@"followerScreenName"];
    self.followerScreenName = [json objectForKey:@"followerName"];
    self.BGImage = [ json objectForKey:@"followerBGImage"];
    self.image = [json objectForKey:@"followerImage"];
    return self;
}
@end
