//
//  DetailViewController.m
//  KKAppStoreToday
//
//  Created by mia on 2018/10/16.
//  Copyright © 2018年 Kong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImgView;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [UIView animateWithDuration:0.25 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self createHeaderView];
}

- (UIView *)createHeaderView{
    self.headerImgView.image = [UIImage imageNamed:self.headerImgName];
    return self.headerImgView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, cell.contentView.bounds.size.width - 40, cell.contentView.bounds.size.height - 40)];
    contentLbl.numberOfLines = 0;
    contentLbl.textColor = [UIColor lightGrayColor];
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.text = @"难道就看到啦睡觉啊垃圾都是垃圾堆里撒娇的时间阿拉蕾的啦滴蜡范德萨垃圾哦肌肤的女生日记诶哦忘记烦恼时愤怒的说愤怒粉丝";
    [contentLbl sizeToFit];
    [cell addSubview:contentLbl];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}
#pragma mark -- Lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 360;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.75)];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImgView;
}

@end
