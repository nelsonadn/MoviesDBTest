//
//  MovieDetailViewController.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/26/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

@synthesize stringMovieID, dictMovie, titleLabel, subTitleLabel, votesLabel, descriptionText, headerImage, coverImage, playButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.stringMovieID);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMovieInfo:) name:@"updateMovieInfo" object:nil];
    // Do any additional setup after loading the view.
    self.businessLogic = [[BusinessLogic alloc] init];
    self.businessLogic.delegate = self;
    [self getMovieInfoFromJSON];
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)getMovieInfoFromJSON{
    NSError *jsonError;
    if ([[ValidationHelpers sharedInstance] fileExistOnPathWithName:self.stringMovieID]){
        self.dictMovie = [NSJSONSerialization JSONObjectWithData:[[BusinessLogic sharedInstance] getSavedJsonDataWithName:self.stringMovieID]
                                                         options:0
                                                           error:&jsonError];
        NSLog(@"%@", self.dictMovie);
        self.playButton.hidden = [[self.dictMovie valueForKey:@"video"]boolValue];
        self.titleLabel.text = [self.dictMovie valueForKey:@"title"];
        self.subTitleLabel.text = [self.dictMovie valueForKey:@"tagline"];
        self.descriptionText.text = [self.dictMovie valueForKey:@"overview"];
        self.votesLabel.text = [NSString stringWithFormat:@"Popularity: %@", [self.dictMovie valueForKey:@"popularity"]];
        [self.businessLogic downloadAndCacheImageFromUrl:[self.dictMovie valueForKey:@"backdrop_path"] isPoster:NO];
        [self.businessLogic downloadAndCacheImageFromUrl:[self.dictMovie valueForKey:@"poster_path"] isPoster:YES];
    }
}

#pragma Local Actions

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playMovie:(id)sender {
    
}

- (IBAction)openWebSite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.dictMovie valueForKey:@"homepage"]]
                                       options:@{}
                             completionHandler:nil];
}

-(void)updateMovieInfo:(NSNotification *)notification{
    [self performSelector:@selector(getMovieInfoFromJSON) withObject:nil afterDelay:3.0];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark BusinessLogicDelegate

-(void)returnImageFromURL:(BusinessLogic*)businessLogic image:(UIImage*)image isPoster:(BOOL)isPoster{
    if (isPoster) {
         self.coverImage.image = image;
    } else {
         self.headerImage.image = image;
    }
}

@end
