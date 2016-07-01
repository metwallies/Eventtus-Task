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
#import "DetailsViewController.h"
#import "CachingManager.h"

@interface HomeViewController () <NetworkManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *followers;
    __weak IBOutlet UITableView *tblViewFollowers;
    int selectedRow;
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
    
    followers = (NSMutableArray *)[[CachingManager sharedInstance] fetchFollowersFromCache];
    if (followers) {
        [tblViewFollowers reloadData];
    } else {
        followers = [[NSMutableArray alloc] init];
    }
    [[NetworkManager sharedInstance] addToObservers:self];
    [[NetworkManager sharedInstance] fetchFollowers];
}

#pragma mark - NetworkManagerDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gotFollowers:(NSArray *)followersArray {
    
    [[NetworkManager sharedInstance] removeFromObservers:self];
    followers = (NSMutableArray *)followersArray;
    [[CachingManager sharedInstance] DeleteFollowersFromCache];
    for (Follower *follower in followersArray) {
        [[CachingManager sharedInstance] saveFollower:follower];
    }
    [tblViewFollowers reloadData];
}

-(void) failedToGetFollowers:(NSString *)error {
    
    [[NetworkManager sharedInstance] removeFromObservers:self];
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:HOME_TO_DETAILS sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailsViewController *details = segue.destinationViewController;
    details.currentFollower = [followers objectAtIndex:selectedRow];
}


@end
