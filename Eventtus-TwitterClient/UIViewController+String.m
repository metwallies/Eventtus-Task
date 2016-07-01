//
//  UIViewController+String.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "UIViewController+String.h"

@implementation UIViewController (String)

-(void) showAlertWithMessage:(NSString *)error {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay"
                                                   style:UIAlertActionStyleDefault
                                                 handler:nil];
    [alert addAction:okay];
    [self showDetailViewController:alert sender:self];
}

@end
