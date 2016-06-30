//
//  Follower.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Follower : NSObject

@property (nonatomic, strong) NSString *followerDescription; //description
@property (nonatomic, strong) NSString *followerID; //id_str
@property (nonatomic, strong) NSString *followerScreenName; //screen_name
@property (nonatomic, strong) NSString *followerName; //name

//initalize a follower object with dictionary.
-(Follower *)initWithDictionary:(NSDictionary *)json;

@end