//
//  IceTextField.m
//  ClassDemo
//
//  Created by 陈冰泽 on 2020/4/17.
//  Copyright © 2020 machong. All rights reserved.
//

#import "IceTextField.h"

@implementation IceTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 8;
    return iconRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 16;
    return editingRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 16;
    return textRect;
}

@end
