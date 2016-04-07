//
//  JCImageViewerView.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCImageViewerView.h"
#import "JCImageZoomingView.h"

@interface JCImageViewerView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageZoomingViews;
@property (nonatomic, assign) int totalImagesCount;

@end

@implementation JCImageViewerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = YES;
        self.delegate = self;
        
        int count = 3;
        _imageZoomingViews = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; i++) {
            JCImageZoomingView *scrollView = [[JCImageZoomingView alloc] initWithFrame:self.bounds];
            [_imageZoomingViews addObject:scrollView];
            [self addSubview:scrollView];
        }
        frame.size.width += JCImageInnerSpace;
        self.frame = frame;
    }
    return self;
}

#pragma mark - public method
- (void)showViewWithIndex:(int)showIndex {
    self.totalImagesCount = (int)[self.dataSource numberOfImagesInImageViewer:self];
    self.contentSize = CGSizeMake(self.frame.size.width * self.totalImagesCount, self.frame.size.height);
    
    int startIndex = showIndex - 1;
    for (JCImageZoomingView *view in self.imageZoomingViews) {
        view.index = startIndex++;
    }
    
    self.currentIndex = showIndex;
    [self loadCurImage];
    [self loadPreviousImage];
    [self loadNextImage];
    self.contentOffset = CGPointMake(self.frame.size.width * self.currentIndex, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = (scrollView.contentOffset.x + 20) / self.frame.size.width;
    if (page == self.currentIndex) {
        return;
    }
    
    if (page > self.currentIndex) {
        [self previousImageZoomingView].index = page + 1;
        self.currentIndex = page;
        [self loadNextImage];
    } else {
        [self nextImageZoomingView].index = page - 1;
        self.currentIndex = page;
        [self loadPreviousImage];
    }
    
    for (JCImageZoomingView *view in self.imageZoomingViews) {
        view.zoomScale = 1.0;
    }
    
    if (page == 0) {
        [[self imageZoomingViewWithIndex:-1] clearView];
    }
    if (page == self.totalImagesCount - 1) {
        [[self imageZoomingViewWithIndex:self.totalImagesCount] clearView];
    }
}

#pragma mark - load image
- (void)loadImageWithIndex:(int)index {
    JCImageZoomingView *view = [self imageZoomingViewWithIndex:index];
    view.entity = [self.dataSource imageViewer:self imageEntityAtIndex:index];
}

- (void)loadCurImage {
    [self loadImageWithIndex:self.currentIndex];
}

- (void)loadPreviousImage {
    if (self.currentIndex > 0) {
        [self loadImageWithIndex:self.currentIndex - 1];
    }
}

- (void)loadNextImage {
    if (self.currentIndex < self.totalImagesCount - 1) {
        [self loadImageWithIndex:self.currentIndex + 1];
    }
}

#pragma mark - image zooming view
- (JCImageZoomingView *)imageZoomingViewWithIndex:(int)index {
    for (JCImageZoomingView *view in self.imageZoomingViews) {
        if (view.index == index) {
            return view;
        }
    }
    return nil;
}

- (JCImageZoomingView *)previousImageZoomingView {
    return [self imageZoomingViewWithIndex:self.currentIndex - 1];
}

- (JCImageZoomingView *)nextImageZoomingView {
    return [self imageZoomingViewWithIndex:self.currentIndex + 1];
}

@end
