//
//  detailView.h
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FDDbController.h"
#import "FDMyAttachment.h"
#import "NSAttributedString+imageExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface detailView : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImagePickerController *imagePickController;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIBarButtonItem *btnHide;
@property (nonatomic, strong) UIBarButtonItem *btnJump;
@property (nonatomic, strong) dbController *db;
@property BOOL newTag;
@property int idNumber;
@property BOOL insertTag;
@property int groupID;
- (void)btnKeyboardHide:(UIBarButtonItem *)btn;
- (void)btnJumpToalbum:(UIBarButtonItem *)btn;
- (void)saveImage:(UIImage *)image Name:(NSString *)name;
- (void)insertImage:(UIImage *)image name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
