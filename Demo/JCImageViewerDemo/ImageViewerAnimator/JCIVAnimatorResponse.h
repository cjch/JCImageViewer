//
//  JCIVAnimatorResponse.h
//  JCImageViewer
//
//  Created by chenjie on 16/4/9.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCImageViewerAnimatorProtocol.h"

@interface JCIVAnimatorResponse : NSObject <JCIVAnimatorResponseProtocol>

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSArray *dataArray;

@end
