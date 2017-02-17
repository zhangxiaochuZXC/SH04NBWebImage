//
//  UIImageView+DSB.h
//  SHWebImage
//
//  Created by itcast on 17/2/17.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloaderOperationManager.h"

@interface UIImageView (DSB)

/*
 分类可以定义分类方法
 不能拓展成员变量
 如果要拓展属性,那么是无法使用的,因为系统不再生成带下划线的成员变量,所以分类的属性不能存值.
 */
@property (nonatomic, copy) NSString *lastUrlString;

- (void)ds_setImageWithUrlString:(NSString *)urlString;

@end
