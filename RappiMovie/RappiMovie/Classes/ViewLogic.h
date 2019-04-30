//
//  ViewLogic.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

@class ViewLogic;

@interface ViewLogic : NSObject

@property (nonatomic) BOOL isLoadedAlert;

+ (id)sharedInstance;

-(void)showAlertWithMessage:(NSString *)stringMessage;
-(void)goToMovieListTableViewController;
-(void)goToMovieDetailViewController:(NSString *)stringMovieID;

@end
