//
//  ViewController.m
//  ClickBtnAnimation
//
//  Created by cyp on 15/12/29.
//  Copyright (c) 2015年 cyp. All rights reserved.
//

#import "ViewController.h"
#import "XYCustomeSegmentControlView.h"
#import "UIView+Frame.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XYCustomeSegmentControlView* xyView = [[XYCustomeSegmentControlView alloc]initWithFrame:CGRectMake(20, 100, 300, 50) withClickBlock:^(NSInteger tag, NSString *title) {
        NSLog(@"%ld ---  %@",tag,title);
    }];
    xyView.titles = @[@"你猜",@"我猜",@"他猜",@"不猜"];
    [self.view addSubview:xyView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
