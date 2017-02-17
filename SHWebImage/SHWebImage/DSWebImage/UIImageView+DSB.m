//
//  UIImageView+DSB.m
//  SHWebImage
//
//  Created by itcast on 17/2/17.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "UIImageView+DSB.h"

@implementation UIImageView (DSB)

//@synthesize lastUrlString = _lastUrlString;

- (void)setLastUrlString:(NSString *)lastUrlString {
    
}

- (NSString *)lastUrlString {
    return nil;
}

- (void)ds_setImageWithUrlString:(NSString *)urlString {

    // 判断连续传入的图片地址是否一样,如果不一样就取消上一次正在执行的操作,反之,就返回,不在建立"重复"的下载操作
    if (![urlString isEqualToString:self.lastUrlString]) {
        
        // 单例管理取消操作
        [[DownloaderOperationManager sharedManager] cancelOperation:self.lastUrlString];
    }
    
    // 记录上次图片地址
    self.lastUrlString = urlString;
    
    // 单例管理下载操作
    [[DownloaderOperationManager sharedManager] downloadImageWithUrlString:urlString finished:^(UIImage *image) {
        // 刷新UI
        self.image = image;
    }];
}

@end
