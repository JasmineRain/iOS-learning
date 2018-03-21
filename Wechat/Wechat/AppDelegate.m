//
//  AppDelegate.m
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "AppDelegate.h"
#import "chatViewController.h"
#import "contactsViewController.h"
#import "discoverViewController.h"
#import "meViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    UITabBarController*tabbarController=[[UITabBarController alloc]init];
    self.window.rootViewController=tabbarController;
    // Override point for customization after application launch.
    UIViewController *chatVC=[[chatViewController alloc]init];
    UIViewController *contactsVC=[[contactsViewController alloc]init];
    UIViewController *discoverVC=[[discoverViewController alloc]init];
    UIViewController *meVC=[[meViewController alloc] init];
    
    
    chatVC.navigationItem.title = @"Wechat(99+)";
    chatVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wechat" image:[UIImage imageNamed:@"code.png"] tag:0];
    contactsVC.navigationItem.title = @"Contacts";
    contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:[UIImage imageNamed:@"trust.png"] tag:1];
    discoverVC.navigationItem.title = @"Discover";
    discoverVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wechat" image:[UIImage imageNamed:@"compass.png"] tag:2];
    meVC.navigationItem.title = @"Me";
    meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Me" image:[UIImage imageNamed:@"account.png"] tag:3];
    
    UINavigationController *chatNC = [[UINavigationController alloc] initWithRootViewController:chatVC];
    UINavigationController *contactsNC = [[UINavigationController alloc] initWithRootViewController:contactsVC];
    UINavigationController *discoverNC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    UINavigationController *meNC = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    tabbarController.viewControllers = @[chatNC,contactsNC,discoverNC,meNC];
    
    
    for (UINavigationController *controller in tabbarController.viewControllers) {
        UIView *view=controller.view;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Wechat"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
