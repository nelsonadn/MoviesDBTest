//
//  ValidationHelpers.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

@interface ValidationHelpers : NSObject

+ (id)sharedInstance;

-(BOOL)isInternetAvailable;
-(BOOL)fileExistOnPathWithName:(NSString *)stringName;

@end
