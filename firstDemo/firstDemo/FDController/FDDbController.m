//
//  dbController.m
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDDbController.h"

@implementation dbController
static sqlite3 *dataBase = nil;
#pragma mark - table operation
- (BOOL)connectToDb{
    NSString *pathString = [NSString stringWithFormat:@"%@/Documents/Table.db",NSHomeDirectory()];
    const char *path = [pathString UTF8String];
    if (dataBase == nil){
        int result = sqlite3_open(path, &dataBase);
        if (result == SQLITE_OK){
            return YES;
        }else{
            int ret = sqlite3_close(dataBase);
            if (ret == SQLITE_OK){
                dataBase = nil;
            }else{
            
            }
            return NO;
        }
    }
     return NO;
}
- (void)createTable{
    NSString *sql = @"CREATE VIRTUAL TABLE IF NOT EXISTS record USING fts3(id INT, datetime TEXT, item TEXT, groupid INT, createdate TEXT)";
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)createTableGroup{
    NSString *sql = @"CREATE VIRTUAL TABLE IF NOT EXISTS class USING fts3(id INT, groupname TEXT)";
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)dropTable{
    NSString *sql = @"DROP TABLE IF EXISTS record";
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)dropTableGroup{
    NSString *sql = @"DROP TABLE IF EXISTS group";
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)closeDb{
    if (sqlite3_close(dataBase) == SQLITE_OK){
        dataBase = nil;
    }
}
#pragma mark - insert operation
- (void)insert:(record *)record{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO record (id, datetime, item, groupid, createdate) values (%d, '%@', '%@', %d, '%@')", record.ID, record.date, record.item, record.groupID, record.date];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)insertGroup:(FDModelGroup *)group{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO class (id, groupname) values (%d, '%@')", group.groupId, group.groupName];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
#pragma mark - update operation
- (void)updateGroup:(FDModelGroup *)group{
    NSString *sql = [NSString stringWithFormat:@"UPDATE class SET groupname='%@' WHERE id=%d", group.groupName, group.groupId];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)update:(record *)record{
    NSString *sql = [NSString stringWithFormat:@"UPDATE record SET item='%@' , datetime='%@' , groupid=%d WHERE id=%d", record.item, record.date, record.groupID, record.ID];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
#pragma mark - delete operation
- (void)deleteGroup:(int)ID{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM class WHERE id=%d", ID];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
    sql = [NSString stringWithFormat:@"DELETE FROM record WHERE groupid=%d", ID];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
- (void)deleteItem:(int)ID{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM record WHERE id=%d ", ID];
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, NULL);
}
#pragma mark - query operation
- (NSMutableArray *)queryAllForGroupID:(int)ID{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM record WHERE groupid=%d", ID];
    sqlite3_stmt *stmt;
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW){
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *datetime = sqlite3_column_text(stmt, 1);
            const unsigned char *item = sqlite3_column_text(stmt, 2);
            int groupID = sqlite3_column_int(stmt, 3);
            const unsigned char *createTime = sqlite3_column_text(stmt, 4);
            record *re = [[record alloc] init];
            re.ID = ID;
            re.date = [[NSString alloc] initWithUTF8String: datetime];
            re.item = [[NSString alloc] initWithUTF8String: item];
            re.createTime = [[NSString alloc] initWithUTF8String: createTime];
            re.groupID = groupID;
            [resultArray addObject:re];
        }
    }
    return resultArray;
}
- (record *)query:(int)ID{
    NSString *sql = [NSString stringWithFormat: @"SELECT * FROM record WHERE id=%d", ID];
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        if (sqlite3_step(stmt) == SQLITE_ROW){
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *datetime = sqlite3_column_text(stmt, 1);
            const unsigned char *item = sqlite3_column_text(stmt, 2);
            int groupID = sqlite3_column_int(stmt, 3);
            const unsigned char *createTime = sqlite3_column_text(stmt, 4);
            record *re = [[record alloc] init];
            re.ID = ID;
            re.date = [[NSString alloc] initWithUTF8String: datetime];
            re.item = [[NSString alloc] initWithUTF8String: item];
            re.createTime = [[NSString alloc] initWithUTF8String: createTime];
            re.groupID = groupID;
            return re;
        }
    }
    return nil;
}
- (NSArray *)queryByItem:(NSString *)item AndGroupID:(int)groupID{
    NSString *sql = [NSString stringWithFormat: @"SELECT * FROM record WHERE item MATCH '%@' AND groupid=%d", item, groupID];
    sqlite3_stmt *stmt;
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW){
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *datetime = sqlite3_column_text(stmt, 1);
            const unsigned char *item = sqlite3_column_text(stmt, 2);
            int groupID = sqlite3_column_int(stmt, 3);
            const unsigned char *createTime = sqlite3_column_text(stmt, 4);
            record *re = [[record alloc] init];
            re.ID = ID;
            re.date = [[NSString alloc] initWithUTF8String: datetime];
            re.item = [[NSString alloc] initWithUTF8String: item];
            re.createTime = [[NSString alloc] initWithUTF8String: createTime];
            re.groupID = groupID;
            [resultArray addObject: re];
        }
    }
    return resultArray;
}
- (NSArray *)queryAllGroup{
    NSString *sql = @"SELECT * FROM class";
    sqlite3_stmt *stmt;
    NSMutableArray *resultArray = [NSMutableArray new];
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW){
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char *groupName = sqlite3_column_text(stmt, 1);
            FDModelGroup *group = [[FDModelGroup alloc] init];
            [group setGroupId:ID GroupName:[[NSString alloc] initWithUTF8String: groupName]];
            [resultArray addObject:group];
        }
    }
    return resultArray;
}
#pragma makr - 聚合运算
- (int)countItem:(int)groupID{
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM record WHERE groupid=%d GROUP BY groupid", groupID];
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        if (sqlite3_step(stmt) == SQLITE_ROW){
            int number = sqlite3_column_int(stmt, 0);
            return number;
        }
    }
    return 0;
}
@end
