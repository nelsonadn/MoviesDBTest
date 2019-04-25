//
//  AppDelegate.h
//  RappiMovie
//
//  Created by Nelson Cruz Mora on 4/25/19.
//  Copyright © 2019 Nelson Cruz Mora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

