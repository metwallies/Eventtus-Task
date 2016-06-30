//
//  HomeViewController.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 6/27/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkManager.h"
#import "UIViewController+String.h"
#import "FollowersCell.h"
#import "Follower.h"

@interface HomeViewController () <NetworkManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *followers;
    __weak IBOutlet UITableView *tblViewFollowers;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // TODO: Change where the log in button is positioned in your view
    followers = [[NSMutableArray alloc] init];
    tblViewFollowers.rowHeight = UITableViewAutomaticDimension;
    tblViewFollowers.estimatedRowHeight = 104.0; //cell height at design.
    [[NetworkManager sharedInstance] addToObservers:self];
    [[NetworkManager sharedInstance] fetchFollowers];
}

#pragma mark - NetworkManagerDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gotFollowers:(NSArray *)followersArray {
    
    [followers addObjectsFromArray:followersArray];
    [tblViewFollowers reloadData];
}

-(void) failedToGetFollowers:(NSString *)error {
    
    [self showAlertWithMessage:error];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return followers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FollowersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Follower *tempFollower = [followers objectAtIndex:indexPath.row];
    [cell setCellWithFollower:tempFollower];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
