//
//  FDRootViewController.h
//  firstDemo
//
//  Created by jupiter on 2020/6/16.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDbController.h"
#import "FDViewController.h"
#import "FDModelGroup.h"
NS_ASSUME_NONNULL_BEGIN

@interface FDRootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) dbController *db;
- (void)btnAddAGroup:(UIBarButtonItem *)btn;
- (void)alertTextFieldDidChange:(NSNotification *)notification;
@end

NS_ASSUME_NONNULL_END
