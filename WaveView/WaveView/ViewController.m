//
//  ViewController.m
//  WaveView
//
//  Created by 周松 on 17/2/28.
//  Copyright © 2017年 周松. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"
@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) WaveView *waveView;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 600) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 245)];
    headView.backgroundColor = [UIColor colorWithRed:164/255.f green:174/255.f blue:246/255.f alpha:1];
    self.tableView.tableHeaderView = headView;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (void)viewDidLayoutSubviews {
    if (!self.waveView) {
        self.waveView = [WaveView addToView:self.tableView.tableHeaderView withFrame:CGRectMake(0, CGRectGetHeight(self.tableView.tableHeaderView.frame) - 4.5, CGRectGetWidth(self.tableView.frame), 5)];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//当滑动结束时会出现水波纹
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.waveView wave]) {
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%i", arc4random() % 100];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
