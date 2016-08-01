//
//  ZJZActionSheet.h
//  ZJZActionSheet
//
//  Created by 郑家柱 on 16/8/1.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SheetCallBack)(NSInteger index);

@interface ZJZActionSheet : UIView

- (void)showWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle otherTitles:(NSArray *)titles completion:(SheetCallBack)completion;

@end
