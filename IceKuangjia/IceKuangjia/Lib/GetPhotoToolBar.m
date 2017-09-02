//
//  GetPhotoToolBar.m
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/8/1.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#import "GetPhotoToolBar.h"

static GetPhotoToolBar *photoToolBar;

@interface GetPhotoToolBar()<
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, copy) PhotoBlock block;

@property (nonatomic, weak) id<GetPhotoToolBarDelegate> delegate;

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation GetPhotoToolBar

static GetPhotoToolBar *photoToolBar;

+ (void)setPhotoDelegate:(id<GetPhotoToolBarDelegate>)delegate getPhotoBlcok:(PhotoBlock)block {
    photoToolBar = [[GetPhotoToolBar alloc] init];
    photoToolBar.delegate = delegate;
    photoToolBar.block = block;
    [photoToolBar openShopVoewSelectedPhoto];
}


- (void)openShopVoewSelectedPhoto {
    if (_delegate) {
        if ([_delegate isKindOfClass:[UIView class]]) {
            _vc = [self viewController:(UIView *)_delegate];
        } else {
            _vc = (UIViewController *)_delegate;
        }
    }else {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cacelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /** 相机 */
        /** 跳转到相机或相册页面 */
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [_vc presentViewController:imagePickerController animated:YES completion:^{
            
        }];

    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /** 跳转到相机或相册页面 */
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [_vc presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }];
    
    /** 判断是否支持相机 */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:cacelAction];
        [alertController addAction:cameraAction];
        [alertController addAction:photoAction];
    } else {
        [alertController addAction:cacelAction];
        [alertController addAction:photoAction];
    }
    [self.vc presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *licenseData = UIImageJPEGRepresentation(img, 0.5);
    NSString *btBase64String = [licenseData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if (photoToolBar.block) {
        photoToolBar.block(img);
    }
}
- (UIViewController *)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
