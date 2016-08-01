//
//  ViewController.m
//  ZJZActionSheet
//
//  Created by 郑家柱 on 16/8/1.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ViewController.h"
#import "ZJZActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionBtn.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
    actionBtn.backgroundColor = [UIColor orangeColor];
    [actionBtn setTitle:@"显示" forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(onActionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionBtn];
    
}

// MARK: 点击时间
- (void)onActionBtnClicked:(UIButton *)button
{
    ZJZActionSheet *sheet = [[ZJZActionSheet alloc] init];
    [sheet showWithTitle:@"自定义ActionSheet" cancleTitle:@"取消" otherTitles:@[@"发送给朋友", @"保存图片", @"收藏", @"投诉"] completion:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
