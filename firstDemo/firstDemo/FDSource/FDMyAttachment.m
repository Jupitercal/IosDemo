//
//  FDMyAttachment.m
//  firstDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDMyAttachment.h"

@implementation FDMyAttachment
- (UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)width{
    CGFloat oriHeight = image.size.height;
    CGFloat oriWidth = image.size.width;
    CGFloat factor = width / oriWidth;
    UIGraphicsBeginImageContext(CGSizeMake(oriWidth * factor, oriHeight *factor));
    [image drawInRect:CGRectMake(0, 0, oriWidth * factor, oriHeight *factor)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSize:(CGFloat)size{
    image = [self compressOriginalImage:image toWidth:150];
    UIImage *oriImage = image;
    
    //初始化压缩范围
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length / 1000.0;
    CGFloat maxQuality = 0.9f;
    //循环压缩
    while (dataKBytes > size){
        //压缩率到达0.1f,则改变图片尺寸
        while (dataKBytes > size && maxQuality > 0.1f){
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if (dataKBytes <= size){
                return data;
            }
        }
        oriImage = [self compressOriginalImage:image toWidth:0.8 * image.size.width];
        image = oriImage;
        data = UIImageJPEGRepresentation(image, 1.0);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.9f;
    }
    return data;
}
@end
