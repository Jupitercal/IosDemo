//
//  ViewController.m
//  collectionViewTest
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ViewController

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil){
        _collectionView = [[UICollectionView alloc] init];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
