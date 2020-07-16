//
//  ViewController.m
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _sortArray = @[@"date", @"createTime", @"item"];
    _presentArray = @[@"按修改时间排序", @"按创建时间排序", @"按文本内容排序"];
    _editButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(btnEdit:)];
    _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAdd:)];
    _addButton.tintColor = [UIColor whiteColor];
    _deleteAll = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(btnDeleteAll:)];
    _selectAll = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStyleDone target:self action:@selector(btnSelectAll:)];
    _sortButton = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStyleDone target:self action:@selector(btnSortMenu:)];
    // self.label.text = [NSString stringWithFormat:@"%lu个备忘录",_listData.count];
    self.view = self.tableView;
    [self.navigationController setToolbarHidden:NO];
    //设置toolbar是否隐藏
    self.tableView.tableHeaderView = self.searchBar;
    self.title = @"备忘录";
    self.navigationItem.rightBarButtonItem = _editButton;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    @autoreleasepool {
        if (!self.searchBar.text.length){
            [self reloadAllData];
            [self reloadToolBar];
            [self searchBarCancelButtonClicked:self.searchBar];
        }
        else{
            [self reloadDataForItem:self.searchBar.text];
        }
    }
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}
#pragma mark - lazyload
- (UILabel *)label{
    if (_label == nil){
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}
- (dbController *)db{
    if (_db == nil){
        _db = [[dbController alloc] init];
        [_db connectToDb];
        [_db createTable];
    }
    return _db;
}
- (UISearchBar *)searchBar{
    if (_searchBar == nil){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder  = @"搜索";
        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (UITableView *)tableView{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSMutableArray *)deleteArray{
    if (_deleteArray == nil){
        _deleteArray = [[NSMutableArray alloc] init];
    }
    return _deleteArray;
}

#pragma mark - button operation
- (void)btnSortMenu:(UIBarButtonItem *)btn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择你所想要的排序方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    for (NSInteger i = 0; i < 3; i++){
        NSString *str = [_presentArray objectAtIndex:i];
        if (i == _sortTag){
            str = [NSString stringWithFormat:@"%@√",str];
        }
        UIAlertAction *Action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            __weak typeof(self) weakSelf = self;
            weakSelf.sortTag = i;
            [weakSelf reloadAllData];
            [weakSelf.tableView reloadData];
        }];
        [alertController addAction:Action];
        if (self.sortTag == i) Action.enabled = NO;
    }
    [alertController addAction: cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)btnEdit:(UIBarButtonItem *)editButton{
    if (!self.tableView.isEditing){
        //导航栏里的加键不显示
        if (self.searchBar.isFirstResponder){
            [self.searchBar setShowsCancelButton:NO animated:YES];
        }
        self.toolbarItems = @[_selectAll];
        self.tableView.tableHeaderView = nil;
    }else {
        if (self.searchBar.text.length == 0){
            [self reloadToolBar];
        }
        self.tableView.tableHeaderView = self.searchBar;
    }
    //允许多行操作
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}
- (void)btnAdd:(UIBarButtonItem *)addButton{
   // [self.searchBar resignFirstResponder];
    [self.searchBar endEditing:NO];
    detailView *dview = [[detailView alloc] init];
    NSDate *Date = [NSDate date];
    NSTimeInterval timeInterval = [Date timeIntervalSince1970];
    dview.idNumber = ((long long int)timeInterval) % 99983121;
    dview.newTag = YES;
    dview.groupID = _groupID;
    [self.navigationController pushViewController:dview animated:YES];
}
- (void)btnSelectAll:(UIBarButtonItem *)selectAll{
    if (self.deleteArray == nil)self.deleteArray = [NSMutableArray new];
    NSInteger length = self.listData.count;
    for (NSInteger i = length - 1; i >= 0; i--){
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.deleteArray addObject:path];
    }
    if (self.deleteArray.count > 0){
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.toolbarItems = @[_selectAll, spaceItem, _deleteAll];
    }
}
- (void)btnDeleteAll:(UIBarButtonItem *)deleteAll{
    NSMutableArray *recArray = [NSMutableArray new];
    if (self.tableView.isEditing && self.deleteArray != nil){
        for (NSIndexPath *path in self.deleteArray){
            record *rec = self.listData[path.row];
            [recArray addObject: rec];
        }
        for (record *rec in recArray){
            [self.listData removeObject:rec];
            [self.db deleteItem:rec.ID];
        }
        [self.tableView deleteRowsAtIndexPaths:self.deleteArray withRowAnimation:UITableViewRowAnimationLeft];
        [self.deleteArray removeAllObjects];
        self.toolbarItems = @[_selectAll];
    }
}
#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    record *rec = [_listData objectAtIndex:indexPath.row];
    [_listData removeObjectAtIndex:indexPath.row];
    [self.db deleteItem:rec.ID];
    [self reloadToolBar];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        //将取消选中的cell的indexPath从数组deleteArr中移除
        [_deleteArray removeObject:indexPath];
        //隐藏删除按钮
        if (_deleteArray.count == 0) {
            self.toolbarItems = @[_selectAll];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.tableView.editing){
        detailView *dview = [[detailView alloc] init];
        dview.idNumber = [[self.listData objectAtIndex:indexPath.row] ID];
        dview.newTag = NO;
        dview.groupID = _groupID;
        [self.navigationController pushViewController:dview animated:YES];
    }else{
        if (self.deleteArray == nil)self.deleteArray = [[NSMutableArray alloc] init];
        [_deleteArray addObject:indexPath];
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.toolbarItems = @[_selectAll, spaceItem, _deleteAll];
    }
}
#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
    }
    record *rec = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text =  [rec presentItem];
    cell.imageView.image = [UIImage systemImageNamed:@"doc.text"];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    longPressGesture.minimumPressDuration = 1.0f;
    [cell addGestureRecognizer:longPressGesture];
    return cell;
}
//长按钮，跳出移动文件夹的框
- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan){
        [self becomeFirstResponder];
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"移动文件夹到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        record *rec = [_listData objectAtIndex:indexPath.row];
        NSArray *groupArray = [self.db queryAllGroup];
        NSInteger length = groupArray.count;
        //给每个group指定一个AlertAction来移动文件夹
        for (NSInteger i = 0; i < length; i++){
            FDModelGroup *group = [groupArray objectAtIndex:i];
            if (group.groupId == rec.groupID){
                continue;
            }
            UIAlertAction *Action = [UIAlertAction actionWithTitle:group.groupName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                __weak typeof(self) weakSelf = self;
                rec.groupID = group.groupId;
                [weakSelf.db update:rec];
                [weakSelf.listData removeObjectAtIndex:indexPath.row];
                [weakSelf.tableView reloadData];
                @autoreleasepool {
                    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                    weakSelf.label.text = [NSString stringWithFormat:@"%lu个备忘录", weakSelf.listData.count];
                    UIBarButtonItem *myItem = [[UIBarButtonItem alloc] initWithCustomView:weakSelf.label];
                    weakSelf.toolbarItems = @[weakSelf.sortButton, spaceItem, myItem, spaceItem, weakSelf.addButton];
                }
            }];
            [alertController addAction:Action];
        }
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark - UISearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar becomeFirstResponder];
    self.toolbarItems = nil;
    [searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    @autoreleasepool {
        if (searchText.length){
            [self reloadDataForItem:searchText];
            [self.tableView reloadData];
        }else{
            [self reloadAllData];
            [self.tableView reloadData];
        }
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    @autoreleasepool {
        [self reloadAllData];
        [self.tableView reloadData];
        searchBar.text = @"";
        [self reloadToolBar];
        [searchBar setShowsCancelButton:NO animated:YES];
    }
}
#pragma mark - overload and reload
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)reloadAllData{
    NSMutableArray *now = [[self.db queryAllForGroupID:_groupID] copy];
    NSSortDescriptor *sort1=[NSSortDescriptor sortDescriptorWithKey:[_sortArray objectAtIndex:_sortTag] ascending:NO];
    self.listData = [[now sortedArrayUsingDescriptors:@[sort1]] mutableCopy];
}
- (void)reloadDataForItem:(NSString *)item{
    NSMutableArray *now = [[self.db queryByItem:item AndGroupID:_groupID] mutableCopy];
    NSSortDescriptor *sort1=[NSSortDescriptor sortDescriptorWithKey:[_sortArray objectAtIndex:_sortTag] ascending:NO];
    self.listData = [[now sortedArrayUsingDescriptors:@[sort1]] mutableCopy];
}
- (void)reloadToolBar{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.label.text = [NSString stringWithFormat:@"%lu个备忘录",_listData.count];
    UIBarButtonItem *myItem = [[UIBarButtonItem alloc] initWithCustomView:self.label];
    self.toolbarItems = @[_sortButton, spaceItem, myItem, spaceItem, _addButton];
}
@end
