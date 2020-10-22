//
//  DLGLockManager.h
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLGLockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLGLockManager : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) id<DLGMemUIViewDelegate> delegate;

+ (DLGLockManager *)shareInstance;

- (void)lock:(DLGLockModel *)model;

@end

NS_ASSUME_NONNULL_END
