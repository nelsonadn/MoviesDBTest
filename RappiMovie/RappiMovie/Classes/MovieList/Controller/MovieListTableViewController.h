//
//  MovieListTableViewController.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/26/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *arrayPopular;
@property (nonatomic) NSArray *arrayTopRated;
@property (nonatomic) NSArray *arrayUncoming;
@property (nonatomic) int randomID;

@end
