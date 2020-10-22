//
//  DLGMemUILockViewCell.m
//  DLGMemor
//
//  Created by 田云翔 on 2020/4/17.
//  Copyright © 2020 DeviLeo. All rights reserved.
//

#import "DLGMemUILockViewCell.h"
#import "Masonry.h"
#import "DLGLockManager.h"

@interface DLGMemUILockViewCell ()

@property (nonatomic, strong) UILabel *myTitleLable;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation DLGMemUILockViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setModel:(DLGLockModel *)model {
    _model = model;
    self.myTitleLable.text = [NSString stringWithFormat:@"%@-%@-%@", model.name, model.address, model.value];
}

- (void)createUI{
    [self addSubview:self.myTitleLable];
    
    [self.myTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@8);
        make.centerY.equalTo(@0);
    }];
}

- (UILabel *)myTitleLable {
    if (!_myTitleLable) {
        _myTitleLable = [[UILabel alloc] init];
    }
    return _myTitleLable;
}

@end
