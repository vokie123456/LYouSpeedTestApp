//
//  UILabel+lineSpacing.h
//  LYouSubscribeApp
//
//  Created by grx on 2018/12/19.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (lineSpacing)
/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
