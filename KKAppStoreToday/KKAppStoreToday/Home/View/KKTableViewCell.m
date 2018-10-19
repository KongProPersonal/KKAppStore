//
//  KKTableViewCell.m
//  KKAppStore
//
//  Created by mia on 2018/10/15.
//  Copyright © 2018年 mia. All rights reserved.
//

#import "KKTableViewCell.h"
#define kMargin 20
#define kWidth self.contentView.bounds.size.width - 2 * kMargin
#define kHeight self.contentView.bounds.size.height - kMargin * 1.4

@interface KKTableViewCell ()



@end

@implementation KKTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setUpUI];
}
- (void)setData:(KKModel *)model{
    self.imgView.image = [UIImage imageNamed:model.imgName];
    
}

- (void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imgView];
    self.imgView.center = CGPointMake(self.bgView.bounds.size.width * 0.5, self.bgView.bounds.size.height * 0.5);
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kMargin * 1.4, kWidth, kHeight)];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.7)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
