//
//  DetailsViewController.m
//  Eventtus-TwitterClient
//
//  Created by islam metwally on 7/1/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "DetailsViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "NetworkManager.h"
#import "UIViewController+String.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource, NetworkManagerDelegate>
{
    NSMutableArray *arrTweets;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBG;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblScreenName;
@property (weak, nonatomic) IBOutlet UITableView *tblViewTweets;
@end

@implementation DetailsViewController

-(void) viewDidLoad {
    
    [super viewDidLoad];
    _tblViewTweets.rowHeight = UITableViewAutomaticDimension;
    _tblViewTweets.estimatedRowHeight = 41.0;
    
    if (_currentFollower.BGImage != nil && ![_currentFollower.BGImage isKindOfClass:[NSNull class]]) {
        [self.imgViewBG setImageWithURL:[NSURL URLWithString:_currentFollower.BGImage]];
    }
    [self.imgViewProfile setImageWithURL:[NSURL URLWithString:_currentFollower.image]];
    self.lblScreenName.text = _currentFollower.followerScreenName;
    
    [[NetworkManager sharedInstance] addToObservers:self];
    [[NetworkManager sharedInstance] FetchTweetsForFollower:_currentFollower];
}

-(void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrTweets.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lblTweet.text = arrTweets[indexPath.row];
    
    return cell;
}

#pragma mark - NetworkManagerDelegate

-(void) gotTweets:(NSArray *)tweets {
    
    [[NetworkManager sharedInstance] removeFromObservers:self];
    arrTweets = (NSMutableArray *)tweets;
    [self.tblViewTweets reloadData];
    
    
}

-(void) failedToGetTweets:(NSString *)error {
    [[NetworkManager sharedInstance] removeFromObservers:self];
    [self showAlertWithMessage:error];
}

@end


