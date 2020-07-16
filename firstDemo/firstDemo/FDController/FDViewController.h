//
//  ViewController.h
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDDetailView.h"
#import "FDDbController.h"
#import "FDMyAttachment.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>;
@property (nonatomic, strong) dbController *db;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;
@property (nonatomic, strong) UIBarButtonItem *sortButton;
@property (nonatomic, strong) NSMutableArray *deleteArray;
@property (nonatomic, strong) UIBarButtonItem *selectAll;
@property (nonatomic, strong) UIBarButtonItem *deleteAll;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSArray *sortArray;
@property (nonatomic, strong) NSArray *presentArray;
@property int groupID;
@property int sortTag;

- (void)btnEdit:(UIButton *)editButton;
- (void)btnAdd:(UIBarButtonItem *)addButton;
- (void)btnDeleteAll:(UIBarButtonItem *)deleteAll;
- (void)btnSelectAll:(UIBarButtonItem *)selectAll;
- (void)btnSortMenu:(UIBarButtonItem *)btn;
- (void)cellLongPress:(UIGestureRecognizer *)recognizer;
- (void)reloadAllData;
- (void)reloadDataForItem:(NSString *)item;
- (void)reloadToolBar;
@end

