//
//  DLGLockModel.h
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLGMemUIViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLGLockModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) DLGMemValueType type;

+ (DLGLockModel *)modelWithAddress:(NSString *)address value:(NSString *)value type:(DLGMemValueType)type;

@end

NS_ASSUME_NONNULL_END
