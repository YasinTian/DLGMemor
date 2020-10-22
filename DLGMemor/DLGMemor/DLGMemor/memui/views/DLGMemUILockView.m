//
//  DLGMemUILockView.m
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import "DLGMemUILockView.h"
#import "Masonry.h"
#import "DLGMemUILockViewCell.h"
#import "DLGLockManager.h"

@interface DLGMemUILockView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DLGMemUILockView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArray = DLGLockManager.shareInstance.dataArray;
        
        [self addSubview:self.tableView];
        [self addSubview:self.closeBtn];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(@0);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(@0);
            make.top.equalTo(self.tableView.mas_bottom);
            make.height.equalTo(@50);
        }];
    }
    return self;
}

- (void)reloadData {
    self.dataArray = [DLGLockManager.shareInstance.dataArray copy];
    [self.tableView reloadData];
}

- (void)close:(UIButton *)btn {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLGMemUILockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DLGMemUILockViewCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        tableView.editing = NO;
        [weakSelf modify:indexPath];
    }];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        tableView.editing = NO;
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return @[action0,action1];
}

- (void)modify:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改数值" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新值";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DLGLockModel *model = weakSelf.dataArray[indexPath.row];
        model.value = [alert.textFields firstObject].text;
        [weakSelf reloadData];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DLGMemUILockViewCell class] forCellReuseIdentifier:@"DLGMemUILockViewCell"];
    }
    return _tableView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:[UIColor redColor]];
        [_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
