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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onButton {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 1; i <= 5; i++) {
        JCImageEntity *entity = [JCImageEntity new];
        entity.name = @(i).stringValue;
        [dataArray addObject:entity];
    }
    JCImageViewerController *viewer = [JCImageViewerController getInstanceWithData:dataArray showIndex:1];
    [self presentViewController:viewer animated:YES completion:nil];
}

@end
