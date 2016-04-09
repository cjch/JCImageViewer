//
//  ViewController.m
//  JCImageViewerDemo
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "ViewController.h"
#import "JCImageViewerController.h"
#import "JCImageEntity.h"
#import "JCImageViewerAnimatorProtocol.h"

static int const Count = 3;

@interface ViewAnimatorResponse : NSObject <JCIVAnimatorResponseProtocol>

@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewAnimatorResponse

- (int)currentImageIndex {
    return self.index;
}

- (UIImageView *)animationImageViewWithIndex:(int)index {
    UIButton *button = self.dataArray[index];
    return button.imageView;
}

@end

@interface ViewController () <JCImageViewerAnimatorProtocol>

@property (nonatomic, strong) ViewAnimatorResponse *animatorResponse;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.buttons = [NSMutableArray array];
    for (int i = 1; i <= Count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 150 * (i-1) + 50, 150, 150)];
        [button setImage:[UIImage imageNamed:@(i).stringValue] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
        [self.buttons addObject:button];
    }
    
    self.animatorResponse = [[ViewAnimatorResponse alloc] init];
    self.animatorResponse.dataArray = self.buttons;
}

- (void)onButton:(UIButton *)sender {
    self.animatorResponse.index = sender.tag - 1;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 1; i <= Count; i++) {
        JCImageEntity *entity = [JCImageEntity new];
        entity.name = @(i).stringValue;
        [dataArray addObject:entity];
    }
    JCImageViewerController *viewer = [JCImageViewerController getInstanceWithData:dataArray showIndex:sender.tag - 1];
    [self presentViewController:viewer animated:YES completion:^{
//        [viewer showWithIndex:sender.tag - 1];
    }];
}


#pragma mark - JCImageViewerAnimatorProtocol
- (id<JCIVAnimatorResponseProtocol>)imageViewerAnimatorResponse {
    return self.animatorResponse;
}

@end
