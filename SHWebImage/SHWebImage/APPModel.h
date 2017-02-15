//
//  APPModel.h
//  12-SDWebImage异步下载网络图片
//
//  Created by itcast on 17/2/14.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPModel : NSObject

/// 名字
@property (nonatomic, copy) NSString *name;
/// 下载量
@property (nonatomic, copy) NSString *download;
/// 图标
@property (nonatomic, copy) NSString *icon;

@end

/*
{
    "name" : "植物大战僵尸",
    "download" : "10311万",
    "icon" : "http:\/\/p16.qhimg.com\/dr\/48_48_\/t0125e8d438ae9d2fbb.png"
}
*/
