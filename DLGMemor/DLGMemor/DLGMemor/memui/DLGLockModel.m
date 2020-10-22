//
//  DLGLockModel.m
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import "DLGLockModel.h"

@implementation DLGLockModel

+ (DLGLockModel *)modelWithAddress:(NSString *)address value:(NSString *)value type:(DLGMemValueType)type {
    DLGLockModel *model = [[DLGLockModel alloc] init];
    model.address = address;
    model.value = value;
    model.type = type;
    return model;
}

@end
