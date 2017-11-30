//
//  ViewController.m
//  TableStack
//
//  Created by Steven Petteruti on 11/30/17.
//  Copyright © 2017 Steven Petteruti. All rights reserved.
//

#import "ViewController.h"
#import "TSUser.h"
#import "TSObjectManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *listOfUsers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.view = tableView;
    
    // fetch the data
    TSObjectManager *sharedManager = [TSObjectManager sharedManager];
    [sharedManager fetchDataWithCallback:^(NSArray *data, NSError *err) {
        if (err == nil) {
            self.listOfUsers = data;
            [tableView reloadData];
        }
        else{
            NSLog(@"error fetching data: %@", err);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listOfUsers count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
    }
    TSUser *user = [self.listOfUsers objectAtIndex:indexPath.row];
    
    // dont update the UI on the mainthread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.textLabel.text = user.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Gold: %@, Silver: %@, Bronze: %@", user.badges[@"gold"], user.badges[@"silver"], user.badges[@"bronze"]];
        
        [cell.imageView sd_setShowActivityIndicatorView:YES];
        [cell.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.link] placeholderImage:[UIImage imageNamed:@"placeholder.png"]   ];
    });
  
    
    return cell;
}



@end
