//
//  JCImageZoomingView.h
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JCImageViewerTapNotification @"com.jc.imageviewer.tap"
#define JCImageInnerSpace 3

@class JCImageEntity;

@interface JCImageZoomingView : UIScrollView

@property (nonatomic, strong) JCImageEntity *entity;
@property (nonatomic, assign) int index;
@property (nonatomic, strong, readonly) UIImageView *imageView;

- (void)clearView;

@end
