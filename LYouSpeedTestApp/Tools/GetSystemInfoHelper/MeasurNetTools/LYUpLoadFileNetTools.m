//
//  LYUpLoadFileNetTools.m
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/8.
//  Copyright © 2019 grx. All rights reserved.
//
#define bound @"boundary"
#import "LYUpLoadFileNetTools.h"
#import "QBTools.h"

@interface LYUpLoadFileNetTools ()
{
    measureUpBlock   infoBlock;
    finishMeasureBlock   fmeasureBlock;
    int                           _second;
    NSInteger                _connectData;
    NSInteger               _oneMinData;
    NSURLConnection *             _connect;
    NSTimer*                      _timer;
    float                      currenProgress;

}
@property (copy, nonatomic) void (^faildBlock) (NSError *error);
@end

@implementation LYUpLoadFileNetTools
/**
 *  初始化测速方法
 *
 *  @param measureBlock       实时返回测速信息
 *  @param finishMeasureBlock 最后完成时候返回平均测速信息
 *
 *  @return MeasurNetTools对象
 */
- (instancetype)initWithblock:(measureUpBlock)measureBlock finishMeasureBlock:(finishMeasureBlock)finishMeasureBlock failedBlock:(void (^) (NSError *error))failedBlock
{
    self = [super init];
    if (self) {
        infoBlock = measureBlock;
        fmeasureBlock = finishMeasureBlock;
        _faildBlock = failedBlock;
        _connectData = 0;
        _oneMinData = 0;
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
    NSURL    *url = [NSURL URLWithString:self.upLoadUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"upLoadFile" ofType:@"mp4"];
    [self POSTFileWithUrlString:self.upLoadUrl FilePath:path FileKey:@"" FileName:@"" SuccessBlock:^(NSData * _Nonnull data, NSURLResponse * _Nonnull response) {
        
    } FailBlock:^(NSError * _Nonnull error) {
        
    }];
    [_timer fire];
    _second = 0;
}

-(void)countTime{
    ++_second;
    if (_second == 15) {
        [self finishMeasure];
        return;
    }
    float speed = _oneMinData;
    infoBlock(speed,currenProgress);
}
/**
 * 测速完成
 */
-(void)finishMeasure{
    NSLog(@"完成===========");
    [_timer invalidate];
    _timer = nil;
    if(_second!=0){
        float finishSpeed = _connectData / _second;
        fmeasureBlock(finishSpeed);
    }
    [_connect cancel];
}

- (void)POSTFileWithUrlString:(NSString *)urlString FilePath:(NSString *)filePath FileKey:(NSString *)key FileName:(NSString *)name SuccessBlock:(SuccessBlock)Success FailBlock:(failBlock)fail
{
    // 1. 创建请求
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",bound];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    // 设置请求体
    request.HTTPBody = [self packageWithPath:filePath fileKey:@"lyUploadfile" fileName:name];
    // 2. 发送请求
    // 在系统内的Block 中调用自己的 成功或者失败的回调
    [NSURLConnection connectionWithRequest:request delegate:self];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 成功或者失败:根据服务器返回的参数判定
//        NSLog(@"上传进度============%@",data);

        //简单举例
        if (data && !connectionError) {  // 成功
            // 调用 成功的回调
            if (Success) {
                Success(data,response);
                [self finishMeasure];
            }
        }else
        {
            if (fail) {
                // 失败之后的回调!
                fail(connectionError);
            }
        }
    }];
}
#pragma mark - urlconnect delegate methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.faildBlock) {
        self.faildBlock(error);
    }
}
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    _connectData = totalBytesWritten;
    _oneMinData = totalBytesWritten;
    currenProgress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
//    NSLog(@"上传进度============%.1ld",(long)_oneMinData);
//    NSLog(@"宽带===Proggy: %@",[QBTools formatBandWidth:totalBytesWritten]);
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    
}


- (NSData *)packageWithPath:(NSString *)filePath fileKey:(NSString *)key fileName:(NSString *)name{
    //根据文件路径，发送同步请求，获得文件信息
    NSURLResponse *response = [self getFileTypeWithPath:filePath];
    
    if (!name) {//如果没有传入name值，默认使用建议的文件名
        name = response.suggestedFilename;
    }
    
    NSMutableString *bodyHeaderStr = [NSMutableString stringWithFormat:@"--%@\r\n",bound];
    [bodyHeaderStr appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",key,name];
    [bodyHeaderStr appendFormat:@"Content-Type: %@\r\n\r\n",response.MIMEType];//两个换行
    
    //文件内容：二进制
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSMutableString *bodyFooterStr = [NSMutableString stringWithFormat:@"\r\n--%@--",bound];
    
    //拼接成二进制数据
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[bodyHeaderStr dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:fileData];
    [bodyData appendData:[bodyFooterStr dataUsingEncoding:NSUTF8StringEncoding]];
    return bodyData;
}

//动态获得文件类型，通过发送一个同步请求
-(NSURLResponse *)getFileTypeWithPath:(NSString *)path{
    //根据本地文件路径，设置一个本地的url
    //file 资源是本地计算机上的文件。格式file:///，注意后边应是三个斜杠(最后一个杠属于传入的路径的一部分,所以下面只有两个杠)。
    NSString *urlstr = [NSString stringWithFormat:@"file://%@",path];
    //发送一个同步请求来获得文件类型
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //(NSURLResponse *__autoreleasing  _Nullable * _Nullable) 有两个**,先指定一块地址，内容为空。等方法执行完毕之后，会将返回的内容存储到这块地址中。
    NSURLResponse *response = nil;
    // 同步请求: 阻塞当前线程
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //MIMEType就是需要的文件类型
    //expectedContentLength文件的长度。一般在文件下载的时候使用，类型是lld
    //suggestedFilename建议的文件名称
    NSLog(@"response: %@ %@ %lld",response.MIMEType, response.suggestedFilename, response.expectedContentLength);
    return response;
}

@end
