//
//  AppDelegate.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "discoverViewController.h"
#import "videoViewController.h"
#import "mineViewController.h"
#import "friendViewController.h"
#import "accountViewController.h"
#import <BmobSDK/Bmob.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

