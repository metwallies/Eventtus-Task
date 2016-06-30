//
//  User.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *authSecret;

-(User *)initWithTwtrSession:(TWTRSession *)session;

@end
