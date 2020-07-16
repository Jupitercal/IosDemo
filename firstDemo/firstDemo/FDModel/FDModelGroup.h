//
//  FDModelGroup.h
//  firstDemo
//
//  Created by jupiter on 2020/6/16.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDModelGroup : NSObject
@property int groupId;
@property NSString *groupName;
- (void)setGroupId:(int)groupId GroupName:(NSString *)groupName;
@end

NS_ASSUME_NONNULL_END
