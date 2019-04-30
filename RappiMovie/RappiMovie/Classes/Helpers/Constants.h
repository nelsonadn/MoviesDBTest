//
//  Constants.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#define DEFAULTS    [NSUserDefaults standardUserDefaults]
#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

//Colors
#define COLOR_RED                     [UIColor colorWithRed:204.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

//Strings
#define APP_NAME    @"Rappi Movie"
#define BASE_URL    @"https://api.themoviedb.org/3/movie"
#define API_KEY     @"ec444b486c683f5744d03dd868e853fa"
#define URL_IMAGE   @"https://image.tmdb.org/t/p/w500/"
#define DEFAULT_LAN     @"language=en-US"
#define POPULAR_MOVIES      @"popular"
#define TOP_RATED_MOVIES    @"top_rated"
#define UPCOMING_MOVIES     @"upcoming"

#define NO_INTERNET @"No internet connection"

# ifdef DEBUG
# undef dispatch_async
# undef dispatch_sync
# undef dispatch_after
# undef dispatch_apply
# undef _dispatch_once
# endif
