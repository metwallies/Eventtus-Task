//
//  UIViewController+String.h
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (String)

//takes a string as a paremter and dispalys it in an alert with title "error"
-(void) showAlertWithMessage:(NSString *)error;

@end
