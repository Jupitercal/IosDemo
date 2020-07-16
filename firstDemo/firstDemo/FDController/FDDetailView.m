//
//  detailView.m
//  firstDemo
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "FDDetailView.h"

@implementation detailView
#pragma mark - lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    _insertTag = 0;
    self.btnHide = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(btnKeyboardHide:)];
    _btnJump = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(btnJumpToalbum:)];
    self.toolbarItems = @[_btnJump];
    self.view = self.bgView;
    [self.navigationController setToolbarHidden:NO];
    [self.view addSubview: self.textView];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - lazyload
- (dbController *)db{
    if (_db == nil){
        _db = [[dbController alloc] init];
        [_db connectToDb];
    }
    return _db;
}
- (UIView *)bgView{
    if (_bgView == nil){
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImagePickerController *)imagePickController{
    if (_imagePickController == nil){
        _imagePickController = [[UIImagePickerController alloc] init];
        _imagePickController.delegate = self;
    }
    return _imagePickController;
}
- (UITextView *)textView{
    if (_textView == nil){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100) textContainer:nil];
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.delegate = self;
        if (!self.newTag){
            record *rec = [self.db query:self.idNumber];
            NSAttributedString *attStr = [rec stringTransferAttributedString];
            [_textView.textStorage insertAttributedString:attStr atIndex:0];
        }
        _textView.font = [UIFont systemFontOfSize:20];
    }
    return _textView;
}
#pragma mark - Button Operation
- (void)btnKeyboardHide:(UIBarButtonItem *)btn{
    [self.textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)btnJumpToalbum:(UIBarButtonItem *)keyBoardToolBar{
    [self.imagePickController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePickController animated:YES completion:nil];
}
#pragma mark -UITextView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    self.navigationItem.rightBarButtonItem = self.btnHide;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    _textView.font = [UIFont systemFontOfSize:20];
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text == nil || textView.text.length == 0) {
        if (!self.newTag){
            [self.db deleteItem:self.idNumber];
        }
        return ;
    }
    record *re = [[record alloc] init];
    // 获得系统时区
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger interval = [zone secondsFromGMTForDate: date];
    //返回以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    NSAttributedString *textString = self.textView.attributedText;
    [re setRecordData:self.idNumber AndDate:localeDate AndItem:textString.textString AndGroupID:_groupID];
    if (self.newTag && !self.insertTag){
        [self.db insert:re];
        self.insertTag = 1;
    }
    else {
        [self.db update:re];
    }
}
#pragma mark - Void List
- (void)insertImage:(UIImage *)image name:(NSString *)name{
    FDMyAttachment *myAttach = [[FDMyAttachment alloc] init];
    myAttach.image = [[UIImage alloc] initWithData:[myAttach compressOriginalImage:image toMaxDataSize:100]];
    myAttach.imageName = name;
    [self.textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:myAttach] atIndex:self.textView.selectedRange.location];
    [self saveImage:myAttach.image Name:name];
    
}
- (void)saveImage:(UIImage *)image Name:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.000001);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]){
        [imageData writeToFile:filePath atomically:YES];
    }
}
#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSMutableString *imageName = [NSMutableString new];
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        NSMutableString *src = [[NSString stringWithFormat:@"%@",(NSString *)[info objectForKey:@"UIImagePickerControllerReferenceURL"]] mutableCopy];
        BOOL Copy = FALSE;
        for (NSInteger i = 0; i < src.length; i++){
            unichar c = [src characterAtIndex:i];
            if (c == '&'){
                break;
            }
            if (c == '='){
                Copy = TRUE;
                continue;
            }
            if (Copy){
                [imageName appendFormat:@"%c",c];
            }
        }
        [imageName appendString:@".jpg"];
    }
    [self insertImage:image name:imageName];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
