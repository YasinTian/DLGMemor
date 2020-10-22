//
//  DLGLockManager.m
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import "DLGLockManager.h"
#import <UIKit/UIKit.h>

@interface DLGLockManager ()
{
    dispatch_source_t _timer;
}
@end

@implementation DLGLockManager

+ (DLGLockManager *)shareInstance {
    static DLGLockManager * instance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[DLGLockManager alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        NSTimeInterval period = 0.1; //设置时间间隔
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            //在这里执行事件
            [weakSelf checkLock];
        });
        dispatch_resume(_timer);
    }
    return self;
}

- (void)checkLock {
    NSMutableArray *deleteArray = [NSMutableArray array];
    for (DLGLockModel *model in self.dataArray) {
        
        mach_vm_address_t a = 0;
        NSScanner *scanner = [NSScanner scannerWithString:model.address];
        if (![scanner scanHexLongLong:&a]) {
            NSLog(@"失效的地址%@", model.address);
            [deleteArray addObject:model];
            continue;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(DLGMemUIModifyValue:address:type:)]) {
            NSLog(@"自动修改-%@-%@", model.address, model.value);
            [self.delegate DLGMemUIModifyValue:model.value address:model.address type:model.type];
        }
    }
    
    [self.dataArray removeObjectsInArray:deleteArray];
}

- (void)lock:(DLGLockModel *)model {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"锁定设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入名称";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        model.name = [alert.textFields firstObject].text;
        [self.dataArray addObject:model];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
