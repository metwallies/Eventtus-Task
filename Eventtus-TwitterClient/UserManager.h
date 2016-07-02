//
//  UserManager.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+(UserManager *) sharedInstance;
-(void) setUserDefaults;

@property (nonatomic ,strong) User *currentLoggedInUser;


@end
