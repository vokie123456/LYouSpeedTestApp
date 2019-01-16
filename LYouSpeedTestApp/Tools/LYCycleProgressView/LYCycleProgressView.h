//
//  QLProgressView.h
//  Test2
//
//  Created by MQL-IT on 2017/8/16.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHotspotLabel.h"

@interface LYCycleProgressView : UIView
@property (nonatomic, assign) CGFloat progress;//进度
@property (nonatomic, strong) UIColor *mainColor;// 主色调,填充颜色和边界颜色
@property (nonatomic, strong) UIColor *fillColor;// 空白和颜色
@property (nonatomic, assign) CGFloat animationDuration;//动画时长
@property (nonatomic, assign) BOOL needAnimation;//是否有动画
@property (nonatomic, assign) CGFloat line_width;//线宽
@property (nonatomic, strong) UILabel *wifiLable;//当前网络
@property (nonatomic, strong) WPHotspotLabel *countJump;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end
