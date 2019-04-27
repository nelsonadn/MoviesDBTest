//
//  MovieListTableViewController.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/26/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "MovieListTableViewController.h"
#import "CollectionCell.h"

@interface MovieListTableViewController ()

@end

@implementation MovieListTableViewController

@synthesize arrayPopular, arrayTopRated, arrayUncoming;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMovieArrays];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initMovieArrays{
    self.arrayPopular = [[NSArray alloc] initWithArray:[self getArrayFromJSON:POPULAR_MOVIES]];
    self.arrayTopRated = [[NSArray alloc] initWithArray:[self getArrayFromJSON:TOP_RATED_MOVIES]];
    self.arrayUncoming = [[NSArray alloc] initWithArray:[self getArrayFromJSON:UPCOMING_MOVIES]];
}

-(NSArray *)getArrayFromJSON:(NSString *)stringName{
    NSError *jsonError;
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:[[BusinessLogic sharedInstance] getSavedJsonDataWithName:stringName]
                                                                 options:0
                                                                   error:&jsonError];
    NSLog(@"%@", jsonResponse);
    NSArray *arrayResult = [jsonResponse valueForKey:@"results"];
    return arrayResult;
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark UITableView DataSource

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:38.0/255.0 alpha:0.9];
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(20, 0, tableView.frame.size.width - 20, 40);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:15];
    if (section == 0) headerLabel.text = @"Recommended for you";
    if (section == 1) headerLabel.text = @"Most Popular";
    if (section == 2) headerLabel.text = @"Top Rated";
    if (section == 3) headerLabel.text = @"Upcoming";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerLabel];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == 0) ? 250 : 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableCellHeader";
        CollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (self.arrayPopular.count > 5) {
            int x = arc4random() % 5;
            cell.stringImageName = [[self.arrayPopular valueForKey:@"backdrop_path"] objectAtIndex:x];
            cell.titleLabel.text= [[self.arrayPopular valueForKey:@"original_title"] objectAtIndex:x];
            cell.subTitleLabel.text = [NSString stringWithFormat:@"%@ votes", [[self.arrayPopular valueForKey:@"vote_count"] objectAtIndex:x]];
            cell.isLoadedCell = YES;
        }
        return cell;
    } else {
        static NSString *CellIdentifier = @"TableCell";
        CollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        switch (indexPath.section) {
            case 1:
                cell.collectionArray = self.arrayPopular;
                break;
            case 2:
                cell.collectionArray = self.arrayTopRated;
                break;
            case 3:
                cell.collectionArray = self.arrayUncoming;
                break;
            default:
                break;
        }
        cell.collectionView.delegate = cell;
        cell.collectionView.dataSource = cell;
        [cell reloadInputViews];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section == 1) {
        CollectionCell* customCell = (CollectionCell*)(cell);
        customCell.isLoadedCell = NO;
    }
}

@end
