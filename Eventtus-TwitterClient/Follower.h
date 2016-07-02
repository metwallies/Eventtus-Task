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
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *BGImage;

//initalize a follower object with dictionary.
-(Follower *)initWithDictionary:(NSDictionary *)json;

//initalize a follower object from dictionary from local cache.
-(Follower *) initWithDictFromCache:(NSDictionary *) dict;

@end
