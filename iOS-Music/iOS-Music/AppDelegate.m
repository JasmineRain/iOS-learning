//
//  AppDelegate.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    UIColor *lightRed= [UIColor colorWithRed:213/255.0 green:59/255.0 blue:51/255.0 alpha:1];
    UIColor *lightGrey= [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1];
    
    UITabBarController*tabbarController=[[UITabBarController alloc]init];
    self.window.rootViewController=tabbarController;
    UIViewController *discoverVC = [[discoverViewController alloc] init];
    UIViewController *videoVC = [[videoViewController alloc] init];
    UIViewController *mineVC = [[mineViewController alloc] init];
    UIViewController *friendVC = [[friendViewController alloc] init];
    UIViewController *accountVC = [[accountViewController alloc] init];
    
    discoverVC.navigationItem.title = @"发现";
    discoverVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"发现.png"] tag:1];
    
    videoVC.navigationItem.title = @"视频";
    videoVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage imageNamed:@"视频.png"] tag:2];
    
    mineVC.navigationItem.title = @"我的音乐";
    mineVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"云.png"] style:UIBarButtonItemStylePlain target:self action:@selector(cloudBtnPressed:)];
    mineVC.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    mineVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"统计.png"] style:UIBarButtonItemStylePlain target:self action:@selector(playBtnPressed:)];
    mineVC.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"音符.png"] tag:3];
    
    friendVC.navigationItem.title = @"朋友";
    friendVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"朋友" image:[UIImage imageNamed:@"朋友.png"] tag:4];
    
    accountVC.navigationItem.title = @"账号";
    accountVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"账号" image:[UIImage imageNamed:@"账号.png"] tag:5];
    accountVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"统计.png"] style:UIBarButtonItemStylePlain target:self action:@selector(playBtnPressed:)];
    accountVC.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    UINavigationController *discoverNC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    [discoverNC.navigationBar setBarTintColor:lightRed];
    [discoverNC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UINavigationController *videoNC = [[UINavigationController alloc] initWithRootViewController:videoVC];
    [videoNC.navigationBar setBarTintColor:lightRed];
    [videoNC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [mineNC.navigationBar setBarTintColor:lightRed];
    [mineNC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    UINavigationController *friendNC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    [friendNC.navigationBar setBarTintColor:lightRed];
    [friendNC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    
    UINavigationController *accountNC = [[UINavigationController alloc] initWithRootViewController:accountVC];
    [accountNC.navigationBar setBarTintColor:lightRed];
    [accountNC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    tabbarController.viewControllers = @[discoverNC,videoNC,mineNC,friendNC,accountNC];
    tabbarController.tabBar.tintColor = [UIColor whiteColor];
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:lightGrey];
    tabBar.translucent = NO;
    
    for (UINavigationController *controller in tabbarController.viewControllers) {
        UIView *view=controller.view;
    }
    
    [Bmob registerWithAppKey:@"be75e488fada2b6e65effe91bba2afbb"];
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
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"iOS_Music"];
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

-(void)cloudBtnPressed:(id)sender{
    NSLog(@"cloud btn pressed");
}

-(void)playBtnPressed:(id)sender{
    NSLog(@"play btn pressed");
}

@end
