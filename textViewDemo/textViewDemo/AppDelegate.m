//
//  AppDelegate.m
//  textViewDemo
//
//  Created by jupiter on 2020/6/12.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navController;
    ViewController *rootvc = [[ViewController alloc] init];
    [self.navController pushViewController:rootvc animated:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UINavigationController *)navController{
    if (_navController == nil){
        _navController = [[UINavigationController alloc] init];
      //  [_navController.navigationBar setHidden:YES];
       // [_navController.toolbar setHidden:NO];
        _navController.navigationBar.barStyle = UIBarStyleBlack;
        _navController.navigationBar.barTintColor = [UIColor blackColor];
        _navController.toolbar.barStyle = UIBarStyleBlack;
        _navController.navigationBar.translucent = NO;
        //[_navController.toolbar setHidden:NO];
        _navController.toolbar.tintColor = [UIColor blueColor];
        _navController.toolbar.barTintColor = [UIColor blackColor];
    }
    return _navController;
}
#pragma mark - UISceneSession lifecycle


@end
