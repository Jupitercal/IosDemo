//
//  ViewController.m
//  tableViewTest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//
#define TABLE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define TABLE_WIDTH [UIScreen mainScreen].bounds.size.width
#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>{
   // BOOL isDelete;
}
@property (nonatomic,strong,nullable) NSMutableArray *letterArray;
@property (nonatomic,strong,nullable) NSMutableArray *numberArray;
@end

@implementation ViewController
#pragma mark - 懒加载
- (UIButton *)btnJump{
    if (_btnJump == nil){
        _btnJump = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnJump.frame = CGRectMake(10, 10, 50, 50);
        _btnJump.backgroundColor = [UIColor whiteColor];
    //    _btnJump.la
        [_btnJump setTitle:@"Jump" forState:UIControlStateNormal];
    }
    return _btnJump;
}

- (UIButton *)btnAdd{
    if (_btnAdd == nil){
        _btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _btnAdd.frame = CGRectMake(300, 10, 50, 50);
        _btnAdd.backgroundColor = [UIColor clearColor];
        _btnAdd.layer.borderColor = [UIColor blackColor].CGColor;
        _btnAdd.layer.cornerRadius = 5;
        [self.view addSubview:_btnAdd];
    }
    return _btnAdd;
}
- (UITableView *)tableView{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, TABLE_WIDTH, TABLE_HEIGHT-100) style:UITableViewStylePlain];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *masterView = [[UIView alloc] init];
    masterView.backgroundColor = [UIColor whiteColor];
    self.view = masterView;
    [self.btnAdd addTarget:self action:@selector(btnAddCell:) forControlEvents:UIControlEventTouchUpInside];
    _numberArray = [[NSMutableArray alloc] initWithObjects:@"123", @"345", @"345", nil];
    _letterArray = [[NSMutableArray alloc] initWithObjects:@"abd", @"adc", @"acc", nil];
    //[_numberArray insertObject:@"1243" atIndex:0];
   // [_letterArray insertObject:@"1243" atIndex:0];
    
    //PLIST简单操作
    NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
    //NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:path];
  //  NSLog(@"-------%@",path);
    self.listData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
   // NSLog(@"%@", [self.listData objectForKey:@"Europe"]);
    /*
    NSArray *tempArray =@[@"123",@"345"];
    [self.listData setObject:tempArray forKey:@"123"];
    [self.listData writeToFile:path atomically:YES];
    */
    [self.btnJump addTarget:self action:@selector(btnJumpTo:) forControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"%@", self.listData.allKeys[0]);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnJump];
    NSLog(@"right");
    // Do any additional setup after loading the view.
}
#pragma mark - Button Operation

- (void)btnAddCell:(UIButton *)btnAdd{
 //   isDelete = YES;
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

- (void)btnJumpTo:(UIButton *)btnJump{
    littleView *vc = [[littleView alloc] init];
    [vc setModalPresentationStyle: UIModalPresentationFullScreen];
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
#pragma mark - UITableViewDetegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

#pragma mark - UITableViewDataSource

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing){
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        /*
        switch (indexPath.section) {
            case 0:
                [self.letterArray removeObjectAtIndex:indexPath.row];
                break;
                
            default:
                [self.numberArray removeObjectAtIndex:indexPath.row];
                break;
        }*/
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
        NSString *sectionName = self.listData.allKeys[indexPath.section];
        NSMutableArray *temp = [[self.listData objectForKey:sectionName] mutableCopy];
        [temp removeObjectAtIndex:indexPath.row];
        //NSLog(@"%@",temp);
        [self.listData removeObjectForKey:sectionName];
        [self.listData setObject:temp forKey:sectionName];
      //  NSLog(@"%@",self.listData);
        //[self.listData writeToFile:path atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else {
        /*
        switch (indexPath.section) {
            case 0:
                [self.letterArray insertObject:@"new letter" atIndex:indexPath.row];
                 break;
            default:
                [self.numberArray insertObject:@"new number" atIndex:indexPath.row];
                break;
        }*/
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
        NSString *sectionName = self.listData.allKeys[indexPath.section];
        NSMutableArray *temp = [[self.listData objectForKey:sectionName] mutableCopy];
        [temp insertObject:@"new item" atIndex:indexPath.row];
        [self.listData removeObjectForKey:sectionName];
        [self.listData setObject:temp forKey:sectionName];
       // [self.listData writeToFile:path atomically:YES];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *sourceName = self.listData.allKeys[sourceIndexPath.section];
    NSString *destName = self.listData.allKeys[destinationIndexPath.section];
    NSString *now = [[self.listData objectForKey:sourceName] objectAtIndex:sourceIndexPath.row];
    NSMutableArray *destArray = [[self.listData objectForKey:destName] mutableCopy];
    [destArray insertObject:now atIndex:destinationIndexPath.row];
    NSMutableArray *sourceArray = [[self.listData objectForKey:sourceName] mutableCopy];
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    [self.listData removeObjectForKey:sourceName];
    [self.listData removeObjectForKey:destName];
    [self.listData setObject:destArray forKey:destName];
    [self.listData setObject:sourceArray forKey:sourceName];
    // 需要改变数据源的排序（略）
  //  NSLog(@"%@",self.listData);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*
     switch (section) {
        case 0:
            return _letterArray.count;
            break;
            
        default:
            return _numberArray.count;
            break;
    }*/
    return [self.listData.allValues[section] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    /*
     switch (section) {
        case 0:
            return @"letterHeader";
            break;
            
        default:
            return @"numberHeader";
            break;
    }*/
    return [NSString stringWithFormat:@"%@ Header",self.listData.allKeys[section]];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    /*
     switch (section) {
        case 0:
            return @"letterFooter";
            break;
            
        default:
            return @"numberFooter";
            break;
    }*/
    return [NSString stringWithFormat:@"%@ Footer",self.listData.allKeys[section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    /*
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.letterArray[indexPath.row];
            break;
            
        default:
            cell.textLabel.text = self.numberArray[indexPath.row];
            break;
    }
     */
    cell.textLabel.text = [self.listData.allValues[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
- (void) viewWillLayoutSubviews{
    NSLog(@"will");
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"xiaoshi");
}
- (void)viewDidDisappear:(BOOL)animated{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
    [self.listData writeToFile:path atomically:YES];
    //NSLog(@"YES %@",self.listData);
    NSLog(@"run");
}
@end

