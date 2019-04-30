//
//  ValidationHelpers.m
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import "ValidationHelpers.h"
#import "Reachability.h"

@implementation ValidationHelpers

#pragma mark Implementing a Singleton

static ValidationHelpers *sharedInstance = nil;

+ (ValidationHelpers *)sharedInstance{
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

-(BOOL)isInternetAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

-(BOOL)fileExistOnPathWithName:(NSString *)stringName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"JSONFiles"];
    NSString *jsonPath=[dataPath stringByAppendingFormat:@"/%@.json", stringName];
    return [[NSFileManager defaultManager] fileExistsAtPath:jsonPath];
}

@end
