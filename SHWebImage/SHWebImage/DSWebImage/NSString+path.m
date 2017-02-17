//
//  NSString+path.m
//  12-SDWebImage异步下载网络图片
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendCachePath {

    // 获取cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 获取文件名字 : self 就是分类方法的调用者
//    NSString *name = [self lastPathComponent];
    
    // 对图片的url进行MD5处理,保证不重名
    NSString *name = [self md5String];
    
    // cache文件路径拼接文件名,生成最后的全路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
    
    return filePath;
}

+ (NSString *)appendCache:(NSString *)url {
    
    // 获取cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 获取文件名字
    NSString *name = [url lastPathComponent];
    // cache文件路径拼接文件名,生成最后的全路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
    
    return filePath;
}

@end
