//
//  FollowersCell.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "FollowersCell.h"
#import "UIImageView+AFNetworking.h"

@implementation FollowersCell

-(void) setCellWithFollower:(Follower *)follower {
    
    self.follower           = follower;
    self.lblBio.text        = follower.followerDescription;
    self.lblName.text       = follower.followerName;
    self.lblScreenName.text = follower.followerScreenName;
    
    [self.imgViewProfile setImageWithURL:[NSURL URLWithString:follower.image]
                        placeholderImage:nil];
}

@end
