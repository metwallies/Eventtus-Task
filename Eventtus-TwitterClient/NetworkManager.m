//
//  NetworkManager.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/29/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "NetworkManager.h"

static NetworkManager *sharedInstance;

@implementation NetworkManager

+(NetworkManager *) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}

-(void) addToObservers:(id<NetworkManagerDelegate>)object {
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self.observers];
    [copy addObject:object];
    self.observers = [NSArray arrayWithArray:copy];
}

-(void) removeFromObservers:(id)object {
    
    NSMutableArray *copy = [NSMutableArray arrayWithArray:self.observers];
    for (int i = 0 ; i < copy.count ; i++) {
        id delegate = copy[i];
        if (delegate == object) {
            [copy removeObject:delegate];
        }
    }
    self.observers = (NSArray *)copy;
    
}

-(void) fetchFollowers {
    
    //https://api.twitter.com/1.1/followers/list.json
    
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                     URL:[NSString stringWithFormat:@"https://api.twitter.com/1.1/followers/list.json?user_id=%@&count=150", [UserManager sharedInstance].currentLoggedInUser.userID]
                                              parameters:nil
                                                   error:nil];
    
    [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError && data) {
            
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableLeaves
                                                                   error:&jsonError];
            if (!jsonError) {
                NSMutableArray *followers = [[NSMutableArray alloc] init];
                NSArray *users = [json objectForKey:@"users"];
                if (users != nil) {
                    for (NSDictionary *jsonFollower in users) {
                        
                        Follower *tempFollower = [[Follower alloc] initWithDictionary:jsonFollower];
                        [followers addObject:tempFollower];
                    }
                    if (followers.count) {
                        
                        [self successGotFollowerBlock:followers];
                    }
                    else {
                        [self failGotFollowerBlock:@"No available followers"];
                    }
                }
                else {
                    [self failGotFollowerBlock:@"No available followers"];
                }
            }
            else {
                [self failGotFollowerBlock:@"Something is wrong with the data"];
            }
        }
        else {
            [self failGotFollowerBlock:@"Connection error"];
        }
    }];
}

-(void) FetchTweetsForFollower:(Follower *) follower{
    
    //https://api.twitter.com/1.1/statuses/user_timeline.json
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                     URL:[NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=%@&count=10", follower.followerID]
                                              parameters:nil
                                                   error:nil];
    [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                          error:nil];
            if (json) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *tempJson in json) {
                    [arr addObject:[tempJson objectForKey:@"text"]];
                }
                if (arr.count) {
                    [self successGotTweetsBlock:arr];
                }
            
                else {
                    [self failGotTweetsBlock:@"No tweets was found"];
                }
            }
            else {
                [self failGotTweetsBlock:@"Something is wrong with the data"];
            }
        }
        else {
            [self failGotTweetsBlock:@"error retrieving tweets"];
        }
    }];
}

//routine upon get followers success
-(void) successGotFollowerBlock:(NSArray *)followers {
    NSArray *copy = [NSArray arrayWithArray:self.observers];
    for (id<NetworkManagerDelegate> observer in copy) {
        
        if ([observer respondsToSelector:@selector(gotFollowers:)]) {
            [observer gotFollowers:followers];
        }
    }
}

//routine upon get followers failure
-(void) failGotFollowerBlock:(NSString *)error {
    NSArray *copy = [NSArray arrayWithArray:self.observers];
    for (id<NetworkManagerDelegate> observer in copy) {
        
        if ([observer respondsToSelector:@selector(failedToGetFollowers:)]) {
            [observer failedToGetFollowers:error];
        }
    }
}

//routine upon get tweets success
-(void) successGotTweetsBlock:(NSArray *)tweets {
    NSArray *copy = [NSArray arrayWithArray:self.observers];
    for (id<NetworkManagerDelegate> observer in copy) {
        
        if ([observer respondsToSelector:@selector(gotTweets:)]) {
            [observer gotTweets:tweets];
        }
    }
}

//routine upon get tweets failure
-(void) failGotTweetsBlock:(NSString *)error {
    NSArray *copy = [NSArray arrayWithArray:self.observers];
    for (id<NetworkManagerDelegate> observer in copy) {
        
        if ([observer respondsToSelector:@selector(failedToGetTweets:)]) {
            [observer failedToGetTweets:error];
        }
    }
}

@end
