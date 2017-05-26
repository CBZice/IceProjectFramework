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
#import "IceCirculationView.h"


@interface FirstViewController ()<IceCirculationViewDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self rightBtnItemWithimgNames:@[@"nav_item_back",@"nav_item_back",@"nav_item_back"] block:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    }];
    
    [self leftBtnItemWithTitle:@"呵呵" block:^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    }];
    
    IceCirculationView *iceCircleView = [[IceCirculationView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 200) Images:@[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3424226810,3788025634&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1984060613,3473764934&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2586472413,677685330&fm=23&gp=0.jpg", @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2261844264,1398222573&fm=23&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2801782160,3456854724&fm=23&gp=0.jpg", @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2348585824,784672926&fm=23&gp=0.jpg", @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=967919111,969882314&fm=23&gp=0.jpg"]];
    iceCircleView.delegate = self;
    [self.view addSubview:iceCircleView];
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
-(void)iceCirculationView:(IceCirculationView *)iceCirculationView whichPicureBeChanged:(NSInteger)index{
    NSLog(@"%ld", (long)index);
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
