//
//  CachingManager.h
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Follower.h"

@interface CachingManager : NSObject

+(id) sharedInstance;

-(void) saveFollower:(Follower*)follower;

-(NSArray *) fetchFollowersFromCache;

-(void) DeleteFollowersFromCache;
@end
