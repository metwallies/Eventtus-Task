//
//  ViewController.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/27/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "UserManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            
            [[UserManager sharedInstance] setCurrentLoggedInUser:[[User alloc] initWithTwtrSession:session]];
            [[UserManager sharedInstance] setUserDefaults];
            
            HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:HOME_IDENTIFIER];
            [[UIApplication sharedApplication].delegate.window setRootViewController:homeVC];
            
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
    }];
    
    // TODO: Change where the log in button is positioned in your view
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
