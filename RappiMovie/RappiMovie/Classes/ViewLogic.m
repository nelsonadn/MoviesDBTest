//
//  ViewLogic.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "ViewLogic.h"
#import "MovieListTableViewController.h"
#import "MovieDetailViewController.h"

@implementation ViewLogic

@synthesize isLoadedAlert;

#pragma mark Implementing a Singleton

static ViewLogic *sharedInstance = nil;

+ (ViewLogic *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init{
    self = [super init];
    self.isLoadedAlert = NO;
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark Local Classes

-(void)showAlertWithMessage:(NSString *)stringMessage{
    if (!self.isLoadedAlert) {
        self.isLoadedAlert = YES;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:APP_NAME
                                                                       message:stringMessage
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *accept = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.isLoadedAlert = NO;
        }];
        [alert addAction:accept];
        [[self currectViewController] presentViewController:alert animated:YES completion:nil];
    }
}

-(void)goToMovieListTableViewController{
    MovieListTableViewController *viewController = (MovieListTableViewController *)[[self getStoryBoard] instantiateViewControllerWithIdentifier:@"MovieListTableViewController"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[self currectViewController] presentViewController:viewController animated:YES completion:nil];
}

-(void)goToMovieDetailViewController:(NSString *)stringMovieID {
    MovieDetailViewController *viewController = (MovieDetailViewController *)[[self getStoryBoard] instantiateViewControllerWithIdentifier:@"MovieDetailViewController"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    viewController.stringMovieID = stringMovieID;
    [[self currectViewController] presentViewController:viewController animated:YES completion:nil];
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@?%@&api_key=%@", BASE_URL, stringMovieID, DEFAULT_LAN, API_KEY];
    [[BusinessLogic sharedInstance] getMovieDetailFromUrl:stringURL andMovieID:stringMovieID];
}

-(UIStoryboard *)getStoryBoard{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

-(UIViewController *)currectViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];;
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end
