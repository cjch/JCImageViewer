//
//  JCImageViewerView.h
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCImageViewerView;
@class JCImageEntity;

@protocol JCImageViewerDataSource <NSObject>

- (NSUInteger)numberOfImagesInImageViewer:(JCImageViewerView *)viewer;
- (JCImageEntity *)imageViewer:(JCImageViewerView *)viewer imageEntityAtIndex:(int)index;

@end

@protocol JCImageViewerDelegate <NSObject>

@optional
- (void)imageViewer:(JCImageViewerView *)viewer didShowImageAtIndex:(int)index;

@end

@interface JCImageViewerView : UIScrollView

@property (nonatomic, weak) id<JCImageViewerDataSource> dataSource;
@property (nonatomic, weak) id<JCImageViewerDelegate> viewerDelegate;
@property (nonatomic, assign) int currentIndex;

- (void)showViewWithIndex:(int)showIndex;
- (UIImageView *)imageViewWithIndex:(int)index;

@end
