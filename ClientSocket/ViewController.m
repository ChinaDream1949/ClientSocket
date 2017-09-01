//
//  ViewController.m
//  ClientSocket
//
//  Created by 欧阳群峰 on 2017/9/1.
//  Copyright © 2017年 肖疆维. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>

// 客户端socket
@property(nonatomic,strong)GCDAsyncSocket *clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.clientSocket connectToHost:@"127.0.0.1" onPort:1234 error:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark GCDAsyncSocketDelegate
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"已经连接成功后调用");
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    // 发送数据
    NSString *str = @"你好，服务器！";
    [self.clientSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    // 接收数据
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
#pragma mark 懒加载
-(GCDAsyncSocket *)clientSocket{
    if (_clientSocket == nil) {
        _clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:NULL];
    }
    return _clientSocket;
}
@end
