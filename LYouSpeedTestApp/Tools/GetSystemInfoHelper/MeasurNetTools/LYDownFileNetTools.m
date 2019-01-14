//
//  MeasurNetTools.m
//  
//
//  Created by jordan on 16/7/25.
//  Copyright © 2016年 MD313. All rights reserved.
//
#define start1 -0.33
#define urlString @"http://down.sandai.net/thunder7/Thunder_dl_7.9.34.4908.exe"//30M
//#define urlString @"http://dl.360safe.com/wifispeed/wifispeed.test"//3M
//#define urlString @"http://bz.pk2game.com/src/video/animals/15441729735128.mp4"//30M

#import "LYDownFileNetTools.h"

@interface LYDownFileNetTools ()
{
    measureBlock   infoBlock;
    finishMeasureBlock   fmeasureBlock;
    int                           _second;
    NSMutableData*                _connectData;
    NSMutableData*                _oneMinData;
    NSURLConnection *             _connect;
    NSTimer*                      _timer;
    float                      currenProgress;
}

@property (copy, nonatomic) void (^faildBlock) (NSError *error);
//本地已经下载了多少
@property (nonatomic, assign) long long currentSize;

@end

@implementation LYDownFileNetTools

/**
 *  初始化测速方法
 *
 *  @param measureBlock       实时返回测速信息
 *  @param finishMeasureBlock 最后完成时候返回平均测速信息
 *
 *  @return MeasurNetTools对象
 */
- (instancetype)initWithblock:(measureBlock)measureBlock finishMeasureBlock:(finishMeasureBlock)finishMeasureBlock failedBlock:(void (^) (NSError *error))failedBlock
{
    self = [super init];
    if (self) {
        infoBlock = measureBlock;
        fmeasureBlock = finishMeasureBlock;
        _faildBlock = failedBlock;
        _connectData = [[NSMutableData alloc] init];
        _oneMinData = [[NSMutableData alloc] init];
        currenProgress = 0;
    }
    return self;
}

/**
 *  开始测速
 */
-(void)startMeasur
{
    [self meausurNet];
}

/**
 *  停止测速，会通过block立即返回测试信息
 */
-(void)stopMeasur
{
    [self finishMeasure];
}

-(void)meausurNet
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    NSURL    *url = [NSURL URLWithString:self.downLoadUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [_timer fire];
    _second = 0;

}

-(void)countTime{
    ++_second;
    if (_second == 15) {
        [self finishMeasure];
        return;
    }
    float speed = _oneMinData.length;
//    if(speed==0.0f){
//        NSLog(@"acde");
//    }
    infoBlock(speed,currenProgress);
    
    //清空数据
    [_oneMinData resetBytesInRange:NSMakeRange(0, _oneMinData.length)];
    [_oneMinData setLength:0];
}

/**
 * 测速完成
 */
-(void)finishMeasure{
    [_timer invalidate];
    _timer = nil;
    if(_second!=0){
        float finishSpeed = _connectData.length / _second;
        fmeasureBlock(finishSpeed);
    }
    
    [_connect cancel];
    _connectData = nil;
    _connect = nil;
    
    
}



#pragma mark - urlconnect delegate methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.faildBlock) {
        self.faildBlock(error);
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_connectData appendData:data];
    [_oneMinData appendData:data];
//    NSLog(@"_oneMinData:%lu  data:%lu",(unsigned long)_oneMinData.length,(unsigned long)data.length);
    //计算下载进度
    self.currentSize += data.length;
    float progress =  self.currentSize/[self getServerFileSize];
//    NSLog(@"文件大小=========%lld",self.currentSize);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    
    [self finishMeasure];
}


//获取文件的总大小(从服务器上获取)
- (long)getServerFileSize{
    //1. url
    NSURL *url = [NSURL URLWithString:self.downLoadUrl];
    //2.request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置HEAD请求方法
    request.HTTPMethod = @"HEAD";
    //创建NSURLResponse
    NSURLResponse *response  = [NSURLResponse new];
    //HEAD请求可以用同步的方法
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    //给文件总长度赋值
    return response.expectedContentLength;
}

- (void)dealloc
{
    NSLog(@"MeasurNetTools dealloc");
}


@end
