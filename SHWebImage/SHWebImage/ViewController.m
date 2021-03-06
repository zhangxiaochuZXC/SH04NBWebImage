//
//  ViewController.m
//  SHWebImage
//
//  Created by itcast on 17/2/15.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "APPModel.h"
#import "UIImageView+DSB.h"

@interface ViewController ()

/// 数据源数组
@property (nonatomic, strong) NSArray *dataSource;
/// 图片控件
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 没有实际意义,仅仅是为了方便测试自定义操作是否可行,为了提供数据的,有了数据在点击屏幕
    [self loadData];
}

/// 获取JSON数据的主方法
- (void)loadData {
    
    NSString *urlStr = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SH04/master/apps.json";
    
    // AFN获取JSON数据
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataSource = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        NSLog(@"%@",self.dataSource);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 需求 : 点击屏幕时使用DownloaderOperation随机下载网络图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 生成随机数
    int random = arc4random_uniform((uint32_t)self.dataSource.count);
    
    // 通过随机数随机获取图片地址(模型)
    APPModel *app = self.dataSource[random];
    
    // 分类实现图片处理
    [self.iconImageView ds_setImageWithUrlString:app.icon];
    
//    // 判断连续传入的图片地址是否一样,如果不一样就取消上一次正在执行的操作,反之,就返回,不在建立"重复"的下载操作
//    if (![app.icon isEqualToString:self.lastUrlString]) {
//        
//        // 单例管理取消操作
//        [[DownloaderOperationManager sharedManager] cancelOperation:self.lastUrlString];
//    }
//    
//    // 记录上次图片地址
//    self.lastUrlString = app.icon;
//
//    // 单例管理下载操作
//    [[DownloaderOperationManager sharedManager] downloadImageWithUrlString:app.icon finished:^(UIImage *image) {
//        // 刷新UI
//        self.iconImageView.image = image;
//    }];
}

/*
- (void)test {
    // 创建队列
    self.queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    // 传入图片地址
    op.urlString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
    
    // 准备代码块
    void (^finishedBlock)(UIImage *) = ^(UIImage *image){
        NSLog(@"%@ %@",image,[NSThread currentThread]);
    };
    // 传递代码块
    op.finishedBlock = finishedBlock;
    
 
     [op setFinishedBlock:^(UIImage *image) {
     }];
 
    
    // 操作添加到队列
    [self.queue addOperation:op];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
