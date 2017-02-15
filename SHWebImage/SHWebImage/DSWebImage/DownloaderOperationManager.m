//
//  DownloaderOperationManager.m
//  SHWebImage
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownloaderOperationManager.h"

@interface DownloaderOperationManager ()

/// 队列
@property (nonatomic, strong) NSOperationQueue *queue;
/// 下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *opCache;

@end

/*
 1.管理下载
 */
@implementation DownloaderOperationManager

+ (instancetype)sharedManager {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc] init];
        self.opCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString finished:(void (^)(UIImage *))finishedBlock {
    
    // 在建立下载操作之前,判断要建立的下载的操作是否存在
    if ([self.opCache objectForKey:urlString] != nil) {
        return;
    }
    
    // finishedBlock : VC传入的代码块
    // 单例定义block传给DownloaderOperation,等到op下载完就回调
    void (^instanceFinishedBlock)(UIImage *) = ^(UIImage *image){
        // 回调VC传入的代码块,把image回调到VC
        if (finishedBlock != nil) {
            finishedBlock(image);
        }
        
        // 移除下载操作缓存池里面的擦做
        [self.opCache removeObjectForKey:urlString];
    };
    // 把随机获取的图片地址传入DownloaderOperation
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithUrlString:urlString finished:instanceFinishedBlock];
    
    // 把下载操作添加到缓存池
    [self.opCache setObject:op forKey:urlString];
    
    // 把操作添加到队列
    [self.queue addOperation:op];
}

@end
