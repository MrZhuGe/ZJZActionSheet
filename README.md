# ZJZActionSheet
仿微信的ActionSheet，简单方便，一个方法即可完成相应功能

// 创建对象
ZJZActionSheet *sheet = [[ZJZActionSheet alloc] init];

// 配置选项
[sheet showWithTitle:@"自定义ActionSheet" cancleTitle:@"取消" otherTitles:@[@"发送给朋友", @"保存图片", @"收藏", @"投诉"] completion:^(NSInteger index) {

    // 完成回调    
    NSLog(@"%ld", index);
}];
