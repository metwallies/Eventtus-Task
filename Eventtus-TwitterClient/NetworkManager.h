//
//  NetworkManager.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/29/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "Follower.h"

@protocol NetworkManagerDelegate <NSObject>

@optional

// called at success getting followers
-(void) gotFollowers:(NSArray *)followers;

//called upon faiulre at getting followers, or followers of count 0
-(void) failedToGetFollowers:(NSString *)error;

// called at success getting tweets
-(void) gotTweets:(NSArray *)tweets;

//called upon faiulre at getting tweets, or tweets of count 0
-(void) failedToGetTweets:(NSString *)error;

@end

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSArray *observers;
@property (nonatomic, strong) id<NetworkManagerDelegate> delegate;

//Return the shared instance of the network manager;
+(NetworkManager *) sharedInstance;

//add a class that conforms the <NetworkManagerDelegate> protocol the array of observers
-(void) addToObservers:(id <NetworkManagerDelegate>)object;
-(void) removeFromObservers:(id)object;

//fires a url to get user followers
-(void) fetchFollowers;

//fires a url to get tweets
-(void) FetchTweetsForFollower:(Follower *)follower;

@end
