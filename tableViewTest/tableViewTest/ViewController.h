//
//  ViewController.h
//  tableViewTest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "littleView.h"

@interface ViewController : UIViewController
@property (nonatomic,strong) UIButton *btnAdd;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *listData;
@property (nonatomic,strong) UIButton *btnJump;
- (void)btnAddCell:(UIButton *)btnAdd;
- (void)btnJumpTo:(UIButton *)btnJump;
@end

