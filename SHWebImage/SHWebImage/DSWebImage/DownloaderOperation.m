//
//  DownloaderOperation.m
//  SHWebImage
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownloaderOperation.h"

/*
 负责图片下载
 1.需要图片的网络地址(URL)
 2.需要回调到外界展示
 */

@interface DownloaderOperation ()

/// 接受外界传入的图片地址
@property (nonatomic, copy) NSString *urlString;
/// 接受外界传入的代码块
@property (nonatomic, copy) void (^finishedBlock)(UIImage *);

@end

@implementation DownloaderOperation

+ (instancetype)downloaderOperationWithUrlString:(NSString *)urlString finished:(void (^)(UIImage *))finishedBlock {
    
    // 创建自定义操作对象
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    // 记录外界传入的数据
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    
    return op;
}

// main只有在队列调度操作后才会执行
// 重写main方法的作用 : 可以在该方法里面指定自定义操作要执行的代码
- (void)main {

    NSLog(@"传入 %@",self.urlString);
    
    // 模拟网络延迟
    [NSThread sleepForTimeInterval:1.0];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    // 图片下载结束之后,需要回调到外界
    if (self.finishedBlock != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }
}

@end
