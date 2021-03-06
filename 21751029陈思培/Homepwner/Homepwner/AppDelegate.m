//
//  AppDelegate.m
//  Homepwner
//
//  Created by air on 05/11/2017.
//  Copyright © 2017 csp. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRItemViewController.h"
#import "BNRitemStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));

    
    // Override point for customization after application launch.
    BNRItemViewController *itemViewController = [[BNRItemViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:itemViewController];
    self.window.rootViewController = navController;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%@",NSStringFromSelector(_cmd));

    BOOL success = [[BNRItemStore sharedStore]saveChanges];
    if(success){
        NSLog(@"Save all of the BNRItems");
    }else{
        NSLog(@"Could not save any of the BNRItems");
    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"%@",NSStringFromSelector(_cmd));

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%@",NSStringFromSelector(_cmd));

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%@",NSStringFromSelector(_cmd));

}


@end
