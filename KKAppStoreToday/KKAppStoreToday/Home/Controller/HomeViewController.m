//
//  HomeViewController.m
//  KKAppStore
//
//  Created by mia on 2018/10/15.
//  Copyright © 2018年 mia. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "KKModel.h"
#import "KKTableViewCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.navigationItem setTitle:@"KKAppStore"];
    self.navigationController.delegate = self;
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKTableViewCell" forIndexPath:indexPath];
    KKModel *model = self.dataArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height * 0.6;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    KKTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    KKModel *model = self.dataArray[indexPath.row];
    detailVC.headerImgName = model.imgName;
    [UIView animateWithDuration:0.25 animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController pushViewController:detailVC animated:YES];
//    });
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndexPath = indexPath;
    KKTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25f animations:^{
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{

    KKTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.selectedIndexPath isEqual:indexPath]) {
        
        [UIView animateWithDuration:0.25f animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    KKTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC valueForKeyPath:@"headerImgView"];
    UITableView *toTableView = (UITableView *)[toVC valueForKey:@"tableView"];
    UIView *fromView = cell.bgView;
    toView.alpha = 0;

    // 1. 设置目标VC的View的frame，目标控制器的view透明度为0
//    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    // 2. 获取容器
    UIView *containerView = [transitionContext containerView];
    
    // 3. 获取跳转时的，过度view
    UIView *snapView = [[UIView alloc] init];
    UIImageView *snapImgView = [[UIImageView alloc] initWithImage:cell.imgView.image];
    snapImgView.frame = toView.frame;
    snapImgView.contentMode = UIViewContentModeScaleAspectFill;
    snapView.layer.cornerRadius = 10;
    snapView.layer.masksToBounds = YES;
    snapView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    toTableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, toTableView.bounds.size.width, toTableView.bounds.size.height);
    toTableView.alpha = 0;
    
    snapImgView.center = CGPointMake(snapView.frame.size.width * 0.5, snapView.frame.size.height * 0.5);
    [snapView addSubview:snapImgView];

    
    // 4. 向过度view上添加执行动画的view
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    
    // 5. 执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext]-0.2 delay:0.0f usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [containerView layoutIfNeeded];
        toVC.view.alpha = 1;
        snapView.layer.cornerRadius = 0;
        snapView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        toTableView.frame = toVC.view.bounds;
        toTableView.alpha = 1;
        
        snapImgView.center = CGPointMake(snapView.frame.size.width * 0.5, snapView.frame.size.height * 0.5);
        
    } completion:^(BOOL finished) {
        toView.alpha = 1;
        [snapView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}


#pragma mark -- Lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 360;
        [_tableView registerClass:[KKTableViewCell class] forCellReuseIdentifier:@"KKTableViewCell"];
    }
    return _tableView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            KKModel *model = [[KKModel alloc] init];
            model.imgName = [NSString stringWithFormat:@"Image%d",i + 1];
            model.contentStr = @"";
            [mutableArr addObject:model];
        }
        _dataArray = mutableArr;
    }
    return _dataArray;
}

@end
