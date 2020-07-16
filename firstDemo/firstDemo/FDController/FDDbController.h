//
//  dbController.h
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FDModelRecord.h"
#import "FDModelGroup.h"
NS_ASSUME_NONNULL_BEGIN

@interface dbController : NSObject
- (BOOL)connectToDb;
- (void)createTable;
- (void)createTableGroup;
- (void)dropTable;
- (void)dropTableGroup;
- (void)closeDb;

- (void)insert:(record *)record;
- (void)insertGroup:(FDModelGroup *)group;

- (NSArray *)queryAllForGroupID:(int)ID;
- (NSArray *)queryAllGroup;
- (record *)query:(int)ID;
- (NSArray *)queryByItem:(NSString *)item AndGroupID:(int)groupID;

- (void)deleteItem:(int)ID;
- (void)deleteGroup:(int)ID;

- (void)update:(record *)record;
- (void)updateGroup:(FDModelGroup *)group;

- (int)countItem:(int)groupID;

@end

NS_ASSUME_NONNULL_END
