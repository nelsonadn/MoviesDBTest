//
//  LoadListViewController.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/26/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "LoadListViewController.h"

@interface LoadListViewController ()

@end

@implementation LoadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController:) name:@"changeViewController" object:nil];
    [self loadInitialList];
}

-(void)changeViewController:(NSNotification *)notification{
    [self goToMovieListTableVC];
}

-(void)goToMovieListTableVC{
    if ([[ValidationHelpers sharedInstance] fileExistOnPathWithName:POPULAR_MOVIES] ||
        [[ValidationHelpers sharedInstance] fileExistOnPathWithName:TOP_RATED_MOVIES] ||
        [[ValidationHelpers sharedInstance] fileExistOnPathWithName:UPCOMING_MOVIES]) {
        [[ViewLogic sharedInstance] goToMovieListTableViewController];
    } else {
        [[ViewLogic sharedInstance] showAlertWithMessage:@"You need a first Sync! :("];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadInitialList{
    if ([[ValidationHelpers sharedInstance] isInternetAvailable]) {
        [[BusinessLogic sharedInstance] updateLocalDataBase:MLPopular numberOfPage:1];
        [[BusinessLogic sharedInstance] updateLocalDataBase:MLTopRated numberOfPage:1];
        [[BusinessLogic sharedInstance] updateLocalDataBase:MLUpcoming numberOfPage:1];
    } else {
        [self performSelector:@selector(goToMovieListTableVC) withObject:nil afterDelay:0.5];
        [self performSelector:@selector(showErrorMessage) withObject:nil afterDelay:2.5];
    }
}

-(void)showErrorMessage{
    [[ViewLogic sharedInstance] showAlertWithMessage:NO_INTERNET];
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
