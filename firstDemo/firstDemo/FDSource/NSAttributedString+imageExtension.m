//
//  NSAttributedString+imageExtension.m
//  firstDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "NSAttributedString+imageExtension.h"

@implementation NSAttributedString (imageExtension)
- (NSString *)textString{
    NSMutableString *textString = [NSMutableString stringWithString:self.string];
    __block NSInteger base = 0;
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop){
        if (value && [value isKindOfClass:[FDMyAttachment class]]){
              [textString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withString:[NSString stringWithFormat:@"{[%@]}",((FDMyAttachment *)value).imageName]];
              //length + 4  - 1: 4是{[]}的长度
              base += ((FDMyAttachment *)value).imageName.length + 3;
          }
    }];
    return textString;
}
@end
