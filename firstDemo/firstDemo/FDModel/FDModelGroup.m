//
//  FDModelGroup.m
//  firstDemo
//
//  Created by jupiter on 2020/6/16.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDModelGroup.h"

@implementation FDModelGroup
- (void)setGroupId:(int)groupId GroupName:(NSString *)groupName{
    self.groupId = groupId;
    self.groupName = [[NSString alloc] initWithString:groupName];
}
@end
