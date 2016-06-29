//
//  NetworkManager.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/29/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@protocol NetworkManagerDelegate <NSObject>

@optional
-(void) gotTweets:(NSArray *)tweets;
-(void) failedToGetTweets:(NSString *)error;

@end

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSArray *observers;

+(NetworkManager *) sharedInstance;

-(void) addToObservers:(id <NetworkManagerDelegate>)object;

-(void) fetchTweetsWithTwtrSession:(TWTRSession *)session;

@end
