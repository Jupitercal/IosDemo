//
//  NSAttributedString+imageExtension.m
//  textViewDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "NSAttributedString+imageExtension.h"

@implementation NSAttributedString (imageExtension)
- (NSString *)textString{
    NSMutableString *textString = [NSMutableString stringWithString:self.string];
    NSLog(@"ONE is %@",textString);
    __block NSInteger base = 0;
 //   NSLog(@"%lu",self.length);
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop){
          if (value && [value isKindOfClass:[myAttachment class]]){
              NSLog(@"range location is %lu,length is %lu", range.location, range.length);
              [textString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withString:[NSString stringWithFormat:@"{[%@]}",((myAttachment *)value).imageName]];
              base += ((myAttachment *)value).imageName.length + 3;
             // NSLog(@"%@",((myAttachment *)value).imageName);
          }
    }];
    return textString;
}
@end
