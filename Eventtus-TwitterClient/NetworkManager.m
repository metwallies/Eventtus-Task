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

-(void) fetchTweetsWithTwtrSession:(TWTRSession *)session {
    
    
}

@end
