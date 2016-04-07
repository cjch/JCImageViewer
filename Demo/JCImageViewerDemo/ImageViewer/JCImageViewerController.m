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
#import "JCImageViewerAnimatorProtocol.h"
#import "JCImageViewerAnimator.h"

@interface ViewerAnimatorResponse : NSObject <JCIVAnimatorResponseProtocol>

@property (nonatomic, weak) JCImageViewerView *viewer;
@property (nonatomic, weak) UIImageView *defaultView;

@end

@implementation ViewerAnimatorResponse

- (int)currentImageIndex {
    return self.viewer.currentIndex;
}

- (UIImageView *)animationImageViewWithIndex:(int)index {
    JCImageZoomingView *currentPage = [self.viewer imageZoomingViewWithIndex:index];
    UIImageView *resView = currentPage.imageView;
    if (resView == nil) {
        resView = self.defaultView;
    }
    return resView;
}


@end


@interface JCImageViewerController () <JCImageViewerDataSource, JCImageViewerAnimatorProtocol>

@property (nonatomic, strong) JCImageViewerView *viewer;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) int defalultShowIndex;

@property (nonatomic, strong) ViewerAnimatorResponse *response;

@end

@implementation JCImageViewerController

+ (instancetype)getInstanceWithData:(NSArray *)dataArray showIndex:(int)index {
    JCImageViewerController *vc = [[JCImageViewerController alloc] init];
    vc.transitioningDelegate = [JCImageViewerAnimator sharedAnimator];
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
    
    _response = [ViewerAnimatorResponse new];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:imageView belowSubview:self.viewer];
    _response.defaultView = imageView;
    _response.viewer = self.viewer;
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

#pragma mark - JCIVAnimatorResponseProtocol
- (id<JCIVAnimatorResponseProtocol>)imageViewerAnimatorResponse {
    return self.response;
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
