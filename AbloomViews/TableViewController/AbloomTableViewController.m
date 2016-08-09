//
//  AbloomTableViewController.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomTableViewController.h"
#import "AbloomTableCell.h"
#import "UIViewController+Transition.h"
#import "AbloomDismissViewController.h"
@interface AbloomTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end
@implementation AbloomTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSourceArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 20; i++) {
        
        NSString *content = [NSString stringWithFormat:@"只愿世间风景千般万般熙攘过后，字里行间，人我两忘，相对无言。 %ld",i];
        NSDictionary *dictionary = @{@"image":[NSString stringWithFormat:@"%ld",i], @"content":content};
        [_dataSourceArray addObject:dictionary];
    }
    [self buildUI];
    [self buildReturnUI];
}


- (void)buildUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, AWidth, AHeight - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[AbloomTableCell class] forCellReuseIdentifier:NSStringFromClass([AbloomTableCell class])];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
                                                                                               
}

- (void)buildReturnUI {
    UIImage *returnImage = [UIImage imageNamed:@"dismissViewReturn"];
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnButton setImage:returnImage forState:UIControlStateNormal];
    [_returnButton setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [_returnButton addTarget:self action:@selector(actionReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_returnButton];
    _returnButton.frame = CGRectMake(0, 30, returnImage.size.width*0.75 + 40, returnImage.size.height*0.75 + 40);
}

- (void)actionReturn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceArray.count) {
        AbloomTableCell *tableCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AbloomTableCell class]) forIndexPath:indexPath];
        tableCell.infoDic = _dataSourceArray[indexPath.row];
        return tableCell;
    }
   
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceArray.count) {
        return [AbloomTableCell heightOfContent:_dataSourceArray[indexPath.row]];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *infoDic = _dataSourceArray[indexPath.row];
    UIImage *image = [UIImage imageNamed:infoDic[@"image"]];
    AbloomDismissViewController *dimissVC = [[AbloomDismissViewController alloc] initWithShownmage:image];
    /**
     *  这是创建所必须的 应用到了AbloomView 
     */
    [self transitionViewByTableView:tableView indexPath:indexPath];
    [self presentAbloomViewController:dimissVC animated:YES completion:nil];
}
@end
