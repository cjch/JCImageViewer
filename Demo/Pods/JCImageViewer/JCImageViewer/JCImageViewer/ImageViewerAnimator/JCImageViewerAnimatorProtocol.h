//
//  JCImageViewerAnimatorProtocol.h
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImageView;

@protocol JCIVAnimatorResponseProtocol <NSObject>

@required
- (int)currentImageIndex;
- (UIImageView *)animationImageViewWithIndex:(int)index;

@end


@protocol JCImageViewerAnimatorProtocol <NSObject>

@required
- (id<JCIVAnimatorResponseProtocol>)imageViewerAnimatorResponse;

@optional
- (void)setAnimatorResponse:(id<JCIVAnimatorResponseProtocol>)response;

@end
