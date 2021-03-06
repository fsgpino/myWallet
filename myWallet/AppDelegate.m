//
//  AppDelegate.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 18/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "AppDelegate.h"
#import "FGPBroker.h"
#import "FGPWallet.h"
#import "FGPWalletTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FGPBroker *broker = [[FGPBroker alloc] init];
    
    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    [broker addRate:3 fromCurrency:@"EUR" toCurrency:@"GBP"];
    [broker addRate:4 fromCurrency:@"EUR" toCurrency:@"INR"];
    
    FGPWallet *wallet = [[[[[[[[[FGPWallet alloc] initWithAmount:20 currency:@"EUR" broker:broker]
                                   plus:[FGPMoney euroWithAmount:40]]
                                  plus:[FGPMoney poundWithAmount:5]]
                                  plus:[FGPMoney poundWithAmount:10]]
                                 plus:[FGPMoney dollarWithAmount:80]]
                                 plus:[FGPMoney dollarWithAmount:10]]
                                 plus:[FGPMoney dollarWithAmount:25]]
                                  plus:[FGPMoney rupeeWithAmount:5]];

    FGPWalletTableViewController *VC = [[FGPWalletTableViewController alloc]initWithModel:wallet];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = navVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
