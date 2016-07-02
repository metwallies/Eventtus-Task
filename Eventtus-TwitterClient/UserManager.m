//
//  UserManager.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "UserManager.h"

static UserManager *sharedInstance;

@implementation UserManager

+(UserManager *) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserManager alloc] init];
    });
    
    return sharedInstance;
}

-(void) setUserDefaults{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLoggedInUser.userID forKey:@"ID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLoggedInUser.screenName forKey:@"screenName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLoggedInUser.userID forKey:@"AuthToken"];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLoggedInUser.userID forKey:@"AuthSecret"];
}

@end
