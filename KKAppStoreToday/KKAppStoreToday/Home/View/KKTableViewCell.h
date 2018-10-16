//
//  KKTableViewCell.h
//  KKAppStore
//
//  Created by mia on 2018/10/15.
//  Copyright © 2018年 mia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKModel.h"


@interface KKTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imgView;

- (void)setData:(KKModel *)model;

@end


