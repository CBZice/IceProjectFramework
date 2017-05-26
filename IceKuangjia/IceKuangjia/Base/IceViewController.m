//
//  IceViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceViewController.h"

@interface IceViewController ()

@property (nonatomic, strong) NavBtn rightNav;

/*** 左边按钮 **/
@property (nonatomic, strong) NavBtn leftNav;

/*** 左右按钮 ，设置布尔值区分， YES是右边按钮**/
@property (assign, nonatomic) BOOL isRight;


@end

@implementation IceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Random_color;
}

- (void)rightBtnItemWithimgNames:(NSArray *)imgStrArr block:(NavBtn)right{
    
    _isRight = YES;
    _rightNav = right;
    NSMutableArray *rightBarItems = [self createBtnItemWithimgNames:imgStrArr];
    self.navigationItem.rightBarButtonItems = rightBarItems;
    
}

- (void)rightBtnItemWithimgName:(NSString *)imgStr block:(NavBtn)right{
    
    _isRight = YES;
    _rightNav = right;
    UIBarButtonItem *rightBarItem = [self createBtnItemWithimgName:imgStr];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

- (void)rightBtnItemWithTitle:(NSString *)title block:(NavBtn)right{
    
    _isRight = YES;
    _rightNav = right;
    UIBarButtonItem *rightBarItem = [self createBtnItemWithTitle:title];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

- (void)leftBtnItemWithimgNames:(NSArray *)imgStrArr block:(NavBtn)left{
    
    _isRight = NO;
    _leftNav = left;
    NSMutableArray *leftBarItems = [self createBtnItemWithimgNames:imgStrArr];
    self.navigationItem.leftBarButtonItems = leftBarItems;
    
}

- (void)leftBtnItemWithimgName:(NSString *)imgStr block:(NavBtn)left{
    
    _isRight = NO;
    _leftNav = left;
    UIBarButtonItem *leftBarItem = [self createBtnItemWithimgName:imgStr];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

- (void)leftBtnItemWithTitle:(NSString *)title block:(NavBtn)left{
    
    _isRight = NO;
    _leftNav = left;
    UIBarButtonItem *leftBarItem = [self createBtnItemWithTitle:title];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}


- (NSMutableArray *)createBtnItemWithimgNames:(NSArray *)imgStrArr{
    
    NSMutableArray *navBarItems = [NSMutableArray array];
    for (int i = 0; i < imgStrArr.count; i++) {
        UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgStrArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(touchRight:)];
        navBarItem.tag = i;
        [navBarItems addObject:navBarItem];
    }
    return navBarItems;
    
}

- (UIBarButtonItem *)createBtnItemWithimgName:(NSString *)imgStr{
    UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(touchRight:)];
    navBarItem.tag = 0;
    return navBarItem;
    
}

- (UIBarButtonItem *)createBtnItemWithTitle:(NSString *)title{
    UIBarButtonItem *navBarItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(touchRight:)];
    
    navBarItem.tag = _isRight;
    
    navBarItem.tag = 0;
    return navBarItem;
    
}
#pragma mark - 点击事件
- (void)touchRight:(UIBarButtonItem *)btn{
    
    if (btn.tag) {
        _rightNav(btn.tag);
        return;
    }
    _leftNav(btn.tag);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
