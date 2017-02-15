//
//  DownloaderOperation.h
//  SHWebImage
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderOperation : NSOperation

/// 接受外界传入的图片地址
@property (nonatomic, copy) NSString *urlString;

@end
