//
//  MovieDetailViewController.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/26/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController <BusinessLogicDelegate>

@property (nonatomic) BusinessLogic *businessLogic;
@property (nonatomic) NSString *stringMovieID;
@property (nonatomic) NSDictionary *dictMovie;

- (IBAction)closeView:(id)sender;
- (IBAction)playMovie:(id)sender;
- (IBAction)openWebSite:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
