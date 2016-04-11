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
    UIImageView *iv = self.dataArray[index];
    return iv;
}

@end

@interface ViewController () <JCImageViewerAnimatorProtocol>

@property (nonatomic, strong) ViewAnimatorResponse *animatorResponse;

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageViews = [NSMutableArray array];
    for (int i = 1; i <= Count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 170 * (i-1) + 50, 150, 150)];
        [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:button.frame];
        iv.image = [UIImage imageNamed:@(i).stringValue];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:button];
        [self.view addSubview:iv];
        [self.imageViews addObject:iv];
    }
    
    self.animatorResponse = [[ViewAnimatorResponse alloc] init];
    self.animatorResponse.dataArray = self.imageViews;
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
