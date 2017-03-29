//
//  FirstViewController.m
//  IceKuangjia
//
//  Created by sanmi on 16/8/5.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "IceNavigationController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rightBtnItemWithimgNames:@[@"nav_item_back",@"nav_item_back",@"nav_item_back"] block:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    
    [self leftBtnItemWithTitle:@"呵呵" block:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
