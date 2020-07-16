//
//  record.m
//  firstDemo
//
//  Created by jupiter on 2020/6/10.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDModelRecord.h"

@implementation record
- (NSDateFormatter *)dateFormat{
    if (_dateFormat == nil){
        _dateFormat = [[NSDateFormatter alloc] init];
        [_dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormat;
}
- (void)setRecordData:(int)Id AndDate:(NSDate *)date AndItem:(NSMutableString *)item AndGroupID:(int)groupID{
    self.ID = Id;
    self.item = item;
    self.date = [self.dateFormat stringFromDate:[NSDate date]];
    self.groupID = groupID;
}
- (NSAttributedString *)stringTransferAttributedString{
    NSString *string = self.item;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.item];
    NSString *zhengze = @"\\{\\[.*?\\]\\}";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [re matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSInteger j=arr.count - 1; j >= 0; j--){
        NSTextCheckingResult *result = arr[j];
        NSString *oriName = [string substringWithRange:result.range];
        NSString *imageName = [oriName substringWithRange:NSMakeRange(2, oriName.length - 4)];
        FDMyAttachment *myAttach = [[FDMyAttachment alloc] init];
        myAttach.image = [self loadImage:imageName];
        myAttach.imageName = imageName;
        [attStr replaceCharactersInRange:result.range withAttributedString:[NSAttributedString attributedStringWithAttachment:myAttach]];
    }
    return attStr;
}
- (UIImage *)loadImage:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

- (NSString *)presentItem{
    NSMutableString *string = [self.item mutableCopy];
    NSString *zhengze = @"\\{\\[.*?\\]\\}";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [re matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSInteger j=arr.count - 1; j >= 0; j--){
        NSTextCheckingResult *result = arr[j];
        [string replaceCharactersInRange:result.range withString:@"[图片]"];
    }
    return string;
}
 
@end
