//
//  AbloomDismissViewController.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/8/9.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomDismissViewController.h"
#import "UIViewController+Transition.h"
@interface AbloomDismissViewController()
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIImage *shownImage;
@end
@implementation AbloomDismissViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    [self.view addSubview:self.showAlboomView];

}

- (instancetype)initWithShownmage:(UIImage *)image {
    if (self = [super init]) {
        _shownImage = image;
        //注意 请将需要展示的View放到这里在创建 在并没有ViewDidload的时候 我们需要获取到showAbloomView的高度和宽度，以及image
        self.showAlboomView = [[UIImageView alloc] init];
        self.showAlboomView.clipsToBounds = YES;
        self.showAlboomView.contentMode = UIViewContentModeScaleAspectFill;
        
        if (_shownImage) {
            CGSize imageSize = _shownImage.size;
            CGFloat scale = imageSize.width / imageSize.height;
            CGFloat height = AWidth / scale;
            self.showAlboomView.frame = CGRectMake(0, 100, AWidth, height);
            self.showAlboomView.image = _shownImage;
        }
    }
    return self;
}

- (void)buildUI {
    UIImage *returnImage = [UIImage imageNamed:@"dismissViewReturn"];
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnButton setImage:returnImage forState:UIControlStateNormal];
    [_returnButton setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [_returnButton addTarget:self action:@selector(actionReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_returnButton];
    _returnButton.frame = CGRectMake(0, 30, returnImage.size.width*0.75 + 40, returnImage.size.height*0.75 + 40);
   }

- (void)actionReturn:(id)sender {
    [self dimissAbloomViewControllerAnimated:YES completion:nil];
}


@end
