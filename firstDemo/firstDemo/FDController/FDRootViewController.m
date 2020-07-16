

//
//  FDRootViewController.m
//  firstDemo
//
//  Created by jupiter on 2020/6/16.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDRootViewController.h"

@interface FDRootViewController ()

@end

@implementation FDRootViewController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAddAGroup:)];
    self.navigationItem.rightBarButtonItem = _addButton;
    _listData = [[self.db queryAllGroup] mutableCopy];
    self.view = self.tableView;
    self.title = @"文件夹";
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"宽度为: %lf", self.view.bounds.size.width);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.listData = [[self.db queryAllGroup] mutableCopy];
    [self.navigationController setToolbarHidden:YES];
    [self.tableView reloadData];
}
#pragma mark - lazyload
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView =
            [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
                                         style:UITableViewStylePlain];
        // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //[_tableView setAutoresizesSubviews:NO];
    }
    return _tableView;
}
- (dbController *)db {
    if (_db == nil) {
        _db = [[dbController alloc] init];
        [_db connectToDb];
        [_db createTableGroup];
    }
    return _db;
}
#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FDModelGroup *group = [_listData objectAtIndex:indexPath.row];
    [_db deleteGroup:group.groupId];
    [_listData removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FDModelGroup *group = [_listData objectAtIndex:indexPath.row];
    ViewController *vc = [[ViewController alloc] init];
    vc.sortTag = 0;
    vc.groupID = group.groupId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
    }
    FDModelGroup *group = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text = group.groupName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d个项目", [self.db countItem:group.groupId]];
    cell.imageView.image = [UIImage systemImageNamed:@"folder"];
    return cell;
}

#pragma mark - button operation
- (void)btnAddAGroup:(UIBarButtonItem *)btn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建文件夹"
                                                                             message:@"请输入文件夹的名字"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"新建"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          FDModelGroup *group = [[FDModelGroup alloc] init];
                                                          NSDate *Date = [NSDate date];
                                                          NSTimeInterval timeInterval = [Date timeIntervalSince1970];
                                                          int groupID = ((long long int)timeInterval) % 99983121;
                                                          [group setGroupId:groupID GroupName:alertController.textFields.firstObject.text];
                                                          [weakSelf.db insertGroup:group];
                                                          weakSelf.listData = [[weakSelf.db queryAllGroup] mutableCopy];
                                                          [weakSelf.tableView reloadData];
                                                          //取消kvo
                                                          [[NSNotificationCenter defaultCenter] removeObserver:self
                                                                                                          name:UITextFieldTextDidChangeNotification
                                                                                                        object:nil];
                                                      }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    // textfield
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = @"文件夹名";
        //限制一定的长度下才可建立文件夹
        addAction.enabled = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertTextFieldDidChange:(NSNotification *)notification {
    UIAlertController *alertController;
    if ([self.presentedViewController isKindOfClass:[UIAlertController class]]) {
        alertController = (UIAlertController *)self.presentedViewController;
    }
    if (alertController) {
        UITextField *textField = alertController.textFields.firstObject;
        UIAlertAction *addAction = alertController.actions.firstObject;
        addAction.enabled = textField.text.length > 0;
    }
}
@end
