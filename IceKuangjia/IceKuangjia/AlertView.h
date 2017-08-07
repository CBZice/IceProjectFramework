//
//  AlertView.h
//  IceKuangjia
//
//  Created by shoujizhifu on 2017/7/20.
//  Copyright © 2017年 sanmi. All rights reserved.
//

#ifndef AlertView_h
#define AlertView_h

//提示信息
#define Alert(mesage,...) {UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:mesage preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}];\
[alertController addAction:otherAction];\
[self presentViewController:alertController animated:YES completion:nil];}

#define AlertView(title, message, ...)  { UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:mesage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alertView show];}

#endif /* AlertView_h */
