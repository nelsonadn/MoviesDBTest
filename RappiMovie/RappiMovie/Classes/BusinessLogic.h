//
//  BusinessLogic.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

typedef enum {
    MLPopular,
    MLTopRated,
    MLUpcoming
} MLRequest;

@class BusinessLogic;

@protocol BusinessLogicDelegate <NSObject>
@optional
-(void)returnImageFromURL:(BusinessLogic*)businessLogic image:(UIImage*)image isPoster:(BOOL)isPoster;

@end


@interface BusinessLogic : NSObject

+ (id)sharedInstance;

@property (weak, nonatomic) id <BusinessLogicDelegate> delegate;

-(void)loadInitialConfiguration;
-(void)updateLocalDataBase:(MLRequest)movieListrequest numberOfPage:(int)page;
-(NSData *)getSavedJsonDataWithName:(NSString *)stringName;
-(void)downloadAndCacheImageFromUrl:(NSString*)strUrl isPoster:(BOOL)isPoster;
-(void)getMovieDetailFromUrl:(NSString *)stringURLRequest andMovieID:(NSString *)movieID;

@end

