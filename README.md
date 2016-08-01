# ZJZActionSheet
仿微信的ActionSheet，简单方便，一个方法即可完成相应功能

ZJZActionSheet *sheet = [[ZJZActionSheet alloc] init];

[sheet showWithTitle:@"自定义ActionSheet" cancleTitle:@"取消" otherTitles:@[@"发送给朋友", @"保存图片", @"收藏", @"投诉"] completion:^(NSInteger index) {
    NSLog(@"%ld", index);
}];
