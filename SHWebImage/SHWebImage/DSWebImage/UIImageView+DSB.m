//
//  UIImageView+DSB.m
//  SHWebImage
//
//  Created by itcast on 17/2/17.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "UIImageView+DSB.h"
#import <objc/runtime.h>

/*
 OC就是对运行时的封装
 可以交换方法的地址
 可以动态的获取对象的属性,给属性赋值 (字典转模型的框架)
 可以动态的获取系统的对象的私有的属性和成员变量 (不要轻易使用,上架会被拒绝)
 关联对象 : 可以动态的给分类的属性建立关联,用于重写分类属性的setter和getter方法,使分类属性可以存值
 */

@implementation UIImageView (DSB)

//@synthesize lastUrlString = _lastUrlString;

- (void)setLastUrlString:(NSString *)lastUrlString {
    
    /*
     参数1 : 要关联的对象,就是当前对象self
     参数2 : 要关联的属性的key,key用来存储属性值
     参数3 : 要关联的属性
     参数4 : 属性的存储策略
     */
    objc_setAssociatedObject(self, "key", lastUrlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastUrlString {
    return objc_getAssociatedObject(self, "key");
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
