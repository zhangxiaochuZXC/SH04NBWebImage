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
 2.
 */

@implementation DownloaderOperation

// main只有在队列调度操作后才会执行
// 重写main方法的作用 : 可以在该方法里面指定自定义操作要执行的代码
- (void)main {

    NSLog(@"传入 %@",self.urlString);
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    NSLog(@"image %@",image);
}

@end
