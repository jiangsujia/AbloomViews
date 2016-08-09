//
//  ViewController.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "ViewController.h"
#import "AbloomTableViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSourceArray = @[@"tableView", @"view"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, AWidth, AHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            AbloomTableViewController *abloomTableVC = [[AbloomTableViewController alloc] init];
            [self presentViewController:abloomTableVC animated:YES completion:nil];

        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
