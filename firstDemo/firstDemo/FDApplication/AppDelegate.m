//
//  AppDelegate.m
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // 2.设置窗口的根控制器
    FDRootViewController *rootVC = [[FDRootViewController alloc] init];
        
        // 创建导航控制器
    self.window.rootViewController = self.navController;
    [self.navController pushViewController:rootVC animated:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UINavigationController *)navController{
    if (_navController == nil){
        _navController = [[UINavigationController alloc] init];
        // 导航栏样式
        _navController.navigationBar.barStyle = UIBarStyleBlack;
        // 字体颜色
        _navController.navigationBar.tintColor = [UIColor whiteColor];
        // 背景view颜色
        _navController.navigationBar.barTintColor = [UIColor clearColor];
        // 设置背景不透明
        _navController.navigationBar.translucent = NO;
        // 工具栏样式
        _navController.toolbar.barStyle = UIBarStyleBlack;
        // 字体颜色
        _navController.toolbar.tintColor = [UIColor whiteColor];
        // 背景view颜色
        _navController.toolbar.barTintColor = [UIColor blackColor];
    }
    return _navController;
}

#pragma mark - UISceneSession lifecycle


@end
