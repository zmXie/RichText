//
//  ViewController.m
//  RichText
//
//  Created by xzm on 2019/1/25.
//  Copyright © 2019 xzm. All rights reserved.
//

#import "ViewController.h"
#import "NSString+zm_Highlight.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupSubViews];
}

- (void)setupData
{
    _dataArray = @[@"消<em>愁</em>",@"一杯敬<em>朝阳</em>，一杯敬<em>月光</em>",@"一杯敬<em>朝阳</em>，一杯敬<em>月光</em>",@"一杯敬<em>故乡</em>，一杯敬<em>远方</em>",@"一杯敬<em>明天</em>，一杯敬<em>过往</em>",@"一杯敬<em>自由</em>，一杯敬<em>死亡</em>",@"反正<em>喝</em>就完事了"];
}

- (void)setupSubViews
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = 0;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textAlignment = 1;
    NSString *text = _dataArray[indexPath.row];
    if (indexPath.section == 0) {
        cell.textLabel.text = text;
    } else {
        cell.textLabel.attributedText = text.zm_highlight;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    label.textAlignment = 1;
    label.text = section == 0 ? @"原数据" : @"高亮效果";
    return label;
}


@end
