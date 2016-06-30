//
//  FollowersCell.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Follower.h"

@interface FollowersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblScreenName;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBio;

@property (nonatomic, strong) Follower *follower;

-(void) setCellWithFollower:(Follower *)follower;

@end
