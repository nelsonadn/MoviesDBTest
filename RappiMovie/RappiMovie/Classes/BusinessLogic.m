//
//  BusinessLogic.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "BusinessLogic.h"

@implementation BusinessLogic

@synthesize delegate;

#pragma mark Implementing a Singleton

static BusinessLogic *sharedInstance = nil;

+ (BusinessLogic *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init{
    self = [super init];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark Local Classes

-(void)loadInitialConfiguration{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoadAPP"]){
        [DEFAULTS setBool:YES forKey:@"firstLoadAPP"];
        [DEFAULTS synchronize];
    }
}

-(void)updateLocalDataBase:(MLRequest)movieListrequest numberOfPage:(int)page{
        NSString *stringAPI = @"";
        switch (movieListrequest) {
            case MLPopular:
                stringAPI = POPULAR_MOVIES;
                break;
            case MLTopRated:
                stringAPI = TOP_RATED_MOVIES;
                break;
            case MLUpcoming:
                stringAPI = UPCOMING_MOVIES;
                break;
            default:
                break;
        }
        [self getMovieListFromUrl:[NSString stringWithFormat:@"%@/%@?page=%d&%@&api_key=%@", BASE_URL, stringAPI, page, DEFAULT_LAN, API_KEY]
               andMLRequestType:stringAPI];
}

-(void)getMovieListFromUrl:(NSString *)stringURLRequest andMLRequestType:(NSString *)movieListType{
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[self mutableURLRequestWithURL:stringURLRequest]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        //[[ViewLogic sharedInstance] showAlertWithMessage:[NSString stringWithFormat:@"%@", error]];
                                                    } else {
                                                        [self saveJsonWithData:data andName:movieListType];
                                                    }
                                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeViewController"  object:self userInfo:nil];
                                                }];
    [dataTask resume];
}

-(void)getMovieDetailFromUrl:(NSString *)stringURLRequest andMovieID:(NSString *)movieID{
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:[self mutableURLRequestWithURL:stringURLRequest]
                                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                         if (error) {
                                                                             NSLog(@"%ld",  (long)[(NSHTTPURLResponse *)response statusCode]);
                                                                             //[[ViewLogic sharedInstance] showAlertWithMessage:[NSString stringWithFormat:@"%@", error]];
                                                                         } else {
                                                                             [self saveJsonWithData:data andName:movieID];
                                                                         }
                                                                         [[NSNotificationCenter defaultCenter]postNotificationName:@"updateMovieInfo"  object:self userInfo:nil];
                                                                     }];
    [dataTask resume];
}


-(NSMutableURLRequest *)mutableURLRequestWithURL:(NSString *)stringURL{
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postData];
    return request;
}

-(void)saveJsonWithData:(NSData *)data andName:(NSString *)stringName {
    NSString *jsonPath=[[self getJSONFilesDirectory] stringByAppendingFormat:@"/%@.json", stringName];
    if ([data writeToFile:jsonPath atomically:YES]){
        NSLog(@"Saved!");
    }
}

-(NSData *)getSavedJsonDataWithName:(NSString *)stringName {
    NSString *jsonPath=[[self getJSONFilesDirectory] stringByAppendingFormat:@"/%@.json", stringName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        return [NSData dataWithContentsOfFile:jsonPath];
    } else {
        return [NSData data];
    }
    
}

-(NSString *)getJSONFilesDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"JSONFiles"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    }
    return dataPath;
}

-(void)downloadAndCacheImageFromUrl:(NSString*)strUrl isPoster:(BOOL)isPoster{
    NSString* theFileName = [NSString stringWithFormat:@"%@.jpg",[[strUrl lastPathComponent] stringByDeletingPathExtension]];
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSString *fileName = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@",theFileName]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *dataFromFile = nil;
        NSData *dataFromUrl = nil;
        dataFromFile = [fileManager contentsAtPath:fileName];
        if(dataFromFile==nil){
            dataFromUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:strUrl]];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageNamed:@"Movie_placeholderCover"];
            if (dataFromFile!=nil ){
                image = [UIImage imageWithData:dataFromFile];
            } else if (dataFromUrl!=nil){
                image = [UIImage imageWithData:dataFromUrl];
                NSString *fileName = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@",theFileName]];
                if(![fileManager createFileAtPath:fileName contents:dataFromUrl attributes:nil]){
                    NSLog(@"Failed to create the file");
                }
            }
            if(self.delegate){
                if([self.delegate respondsToSelector:@selector(returnImageFromURL:image:isPoster:)]){
                    [self.delegate returnImageFromURL:self image:image isPoster:isPoster];
                }
            }
            //Return Image
            
        });
    });
}

@end
