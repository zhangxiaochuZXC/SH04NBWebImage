//
//  DownloaderOperationManager.h
//  SHWebImage
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloaderOperation.h"

@interface DownloaderOperationManager : NSObject

/// 单例全局访问点
+ (instancetype)sharedManager;


/**
 单例管理下载的主方法

 @param urlString 下载地址
 @param finishedBlock 下载完成的回调
 */
- (void)downloadImageWithUrlString:(NSString *)urlString finished:(void (^)(UIImage *image))finishedBlock;

@end
