//
//  JCImageViewerController.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCImageViewerController.h"
#import "JCImageViewerView.h"
#import "JCImageZoomingView.h"

@interface JCImageViewerController () <JCImageViewerDataSource>

@property (nonatomic, strong) JCImageViewerView *viewer;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) int defalultShowIndex;

@end

@implementation JCImageViewerController

+ (instancetype)getInstanceWithData:(NSArray *)dataArray showIndex:(int)index {
    JCImageViewerController *vc = [[JCImageViewerController alloc] init];
    vc.dataArray = dataArray;
    vc.defalultShowIndex = index;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewer];
    [self.viewer showViewWithIndex:self.defalultShowIndex];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePan) name:JCImageViewerTapNotification object:nil];
}

- (void)handlePan {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - JCImageViewerDataSource
- (NSUInteger)numberOfImagesInImageViewer:(JCImageViewerView *)viewer {
    return self.dataArray.count;
}

- (JCImageEntity *)imageViewer:(JCImageViewerView *)viewer imageEntityAtIndex:(int)index {
    JCImageEntity *entity = self.dataArray[index];
    return entity;
}

#pragma mark
- (JCImageViewerView *)viewer {
    if (!_viewer) {
        _viewer = [[JCImageViewerView alloc] initWithFrame:self.view.bounds];
        _viewer.dataSource = self;
    }
    return _viewer;
}

@end
