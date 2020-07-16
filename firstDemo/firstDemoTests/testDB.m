//
//  testDB.m
//  firstDemoTests
//
//  Created by jupiter on 2020/6/10.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FDDbController.h"
@interface testDB : XCTestCase

@end

@implementation testDB

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    dbController *dbC = [[dbController alloc] init];
    NSLog(@"test begin");
    //XCTAssert([dbC connectToDb] == YES  ? TRUE : FALSE, );
    [dbC createTable];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
