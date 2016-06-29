//
//  HomeViewController.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/27/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) TWTRSession *currentSession;

@end
