//
//  ZJZActionSheet.m
//  ZJZActionSheet
//
//  Created by 郑家柱 on 16/8/1.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ZJZActionSheet.h"

#define KZJZACTIONSHEETCELLID   @"ZJZActionSheetCellID"

static const CGFloat actionSheetTime = 0.4f;

@interface ZJZActionSheet () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/*
 列表
 */
@property (nonatomic, strong) UITableView   *sheetView;

/*
 标题
 */
@property (nonatomic, strong) NSString      *title;

/*
 取消标题
 */
@property (nonatomic, strong) NSString      *cancleTitle;

/*
 其它标题
 */
@property (nonatomic, strong) NSArray       *titles;

/*
 列表高度
 */
@property (nonatomic, assign) CGFloat       sheetHeight;

/*
 回调方法
 */
@property (nonatomic, strong) SheetCallBack sheetCallBack;

@end

@implementation ZJZActionSheet

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIWindow *keyWindow = [self currentKeyWindow];
        self.frame = keyWindow.frame;
        self.backgroundColor = [UIColor clearColor];
        [keyWindow addSubview:self];
    }
    return self;
}

- (void)showWithTitle:(NSString *)title cancleTitle:(NSString *)cancleTitle otherTitles:(NSArray *)titles completion:(SheetCallBack)completion
{
    
    self.title = title;
    self.cancleTitle = cancleTitle;
    self.titles = titles;
    
    self.sheetCallBack = completion;
    
    // 计算高度
    self.sheetHeight = [self countSheetHeight];
    
    // 支持点击手势取消
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGRClicked)];
    tapGR.delegate = self;
    [self addGestureRecognizer:tapGR];
    
    [self initTableView];
    
}

// MARK: 计算高度
- (CGFloat)countSheetHeight
{
    CGFloat height = self.titles.count * 40;
    
    if (self.title) {
        height += 40;
    }
    
    if (self.cancleTitle) {
        height += 50;
    }
    
    return height;
}

// MARK: 初始化UITableView
- (void)initTableView
{
    self.sheetView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.sheetHeight) style:UITableViewStylePlain];
    self.sheetView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.8f];
    self.sheetView.delegate = self;
    self.sheetView.dataSource = self;
    self.sheetView.scrollEnabled = NO;
    self.sheetView.separatorInset = UIEdgeInsetsZero;
    self.sheetView.layoutMargins = UIEdgeInsetsZero;
    self.sheetView.separatorColor = [UIColor darkGrayColor];
    [self addSubview:self.sheetView];
    
    // 注册CELL
    [self.sheetView registerClass:[UITableViewCell class] forCellReuseIdentifier:KZJZACTIONSHEETCELLID];
    
    // 执行弹出动画
    [UIView animateWithDuration:actionSheetTime animations:^{
        self.sheetView.frame = CGRectMake(0, self.frame.size.height - self.sheetHeight, self.frame.size.width, self.sheetHeight);
    }];
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cancleTitle) {
        return 2;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.titles.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.title) {
            return 40;
        }
        return 0;
    }
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.text = self.title;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        return titleLabel;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:0.6f];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KZJZACTIONSHEETCELLID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.titles[indexPath.row];
    } else {
        cell.textLabel.text = self.cancleTitle;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        self.sheetCallBack(indexPath.row);
    } else {
        self.sheetCallBack(self.titles.count);
    }
    
    [self onTapGRClicked];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}

// MARK: UIGestureRegcognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

// MARK: 手势
- (void)onTapGRClicked
{
    [UIView animateWithDuration:actionSheetTime animations:^{
        self.sheetView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.sheetHeight);
    } completion:^(BOOL finished) {
        [self.sheetView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

// MARK: 查找最上层的Window
- (UIWindow *)currentKeyWindow
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    for (UIWindow *win in frontToBackWindows) {
        if (win.screen == mainScreen && win.windowLevel == UIWindowLevelNormal) {
            return win;
        }
    }
    
    return [[UIApplication sharedApplication] keyWindow];
}

@end
