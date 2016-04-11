//
//  JCImageZoomingView.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCImageZoomingView.h"
#import "JCImageEntity.h"

static const CGFloat MaxZoomingScale = 2.0;
static const CGFloat MinZoomingScale = 1.0;

@interface JCImageZoomingView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JCImageZoomingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = self.showsVerticalScrollIndicator = NO;
        self.maximumZoomScale = MaxZoomingScale;
        self.minimumZoomScale = MinZoomingScale;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return self;
}

#pragma mark -
- (void)setEntity:(JCImageEntity *)entity {
    _entity = entity;
    self.imageView.image = [UIImage imageNamed:entity.name];
}

- (void)setIndex:(int)index {
    _index = index;
    CGFloat width = self.frame.size.width;
    self.frame = CGRectMake((width + JCImageInnerSpace) * index, 0, width, self.frame.size.height);
    self.imageView.image = nil;
}

- (void)clearView {
    self.imageView.image = nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (touches.count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:JCImageViewerTapNotification object:nil];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
