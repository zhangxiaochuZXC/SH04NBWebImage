//
//  NSString+path.h
//  12-SDWebImage异步下载网络图片
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Hash.h"

@interface NSString (path)

+ (NSString *)appendCache:(NSString *)url;

- (NSString *)appendCachePath;

@end
