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
/// 图片缓存池
@property (nonatomic, strong) NSMutableDictionary *imageCache;

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
        self.imageCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString finished:(void (^)(UIImage *))finishedBlock {
    
    // 判断是否有图片缓存
    if ([self checkCache:urlString] == YES) {
        // 如果有缓存就从缓存中取出图片,然后直接回调给外界
        finishedBlock([self.imageCache objectForKey:urlString]);
        return;
    }
    
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
        
        // 缓存图片到内存缓存池
        [self.imageCache setObject:image forKey:urlString];
        
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

/// 检测是否有图片缓存
- (BOOL)checkCache:(NSString *)urlString {
    
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"内存中... %@",urlString);
        return YES;
    }
    
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[urlString appendCachePath]];
    if (cacheImage != nil) {
        NSLog(@"沙盒中... %@",urlString);
        // 再在内存缓存中存一份
        [self.imageCache setObject:cacheImage forKey:urlString];
        return YES;
    }

    return NO;
}

- (void)cancelOperation:(NSString *)lastUrlString {
    
    // 取消操作
    DownloaderOperation *lastOp = [self.opCache objectForKey:lastUrlString];
    if (lastOp != nil) {
        // 仅仅是修改了canceled属性为YES而已
        [lastOp cancel];
        // 取消的操作需要移除
        [self.opCache removeObjectForKey:lastUrlString];
    }
}

@end
