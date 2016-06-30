//
//  User.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "User.h"

@implementation User

-(User *) initWithTwtrSession:(TWTRSession *)session {
    
    self = [super init];
    
    self.userID = session.userID;
    self.screenName = session.userName;
    self.authToken = session.authToken;
    self.authSecret = session.authTokenSecret;
    
    return self;
}

@end
