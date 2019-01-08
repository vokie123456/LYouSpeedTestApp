//
//  LYUpLoadFileNetTools.h
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/8.
//  Copyright © 2019 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUpLoadFileNetTools : NSObject
// 定义两个 Block : 1. 成功Block回调 2.失败的 Block 回调!
typedef void(^SuccessBlock)(NSData *data, NSURLResponse *response);
typedef void(^failBlock)(NSError *error);

typedef void (^measureUpBlock) (float speed, float progress);
typedef void (^finishMeasureBlock) (float speed);

@property(nonatomic,strong) NSString *upLoadUrl;
/**
 *  初始化测速方法
 *
 *  @param measureBlock       实时返回测速信息
 *  @param finishMeasureBlock 最后完成时候返回平均测速信息
 *
 *  @return MeasurNetTools对象
 */
- (instancetype)initWithblock:(measureUpBlock)measureBlock finishMeasureBlock:(finishMeasureBlock)finishMeasureBlock failedBlock:(void (^) (NSError *error))failedBlock;

/**
 *  开始测速
 */
-(void)startMeasur;

/**
 *  停止测速，会通过block立即返回测试信息
 */
-(void)stopMeasur;

@end

NS_ASSUME_NONNULL_END
