//
//  testDelegate.h
//  MRCTest
//
//  Created by jupiter on 2020/6/4.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface testDelegate : NSObject;
@property(weak) id<AProtocol> delegate;
-(void)testDelegatePrint;
@end

NS_ASSUME_NONNULL_END
