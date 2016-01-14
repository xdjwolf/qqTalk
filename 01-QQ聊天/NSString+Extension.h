//
//  NSString+Extension.h
//  01-QQ聊天
//
//  Created by Apple on 16/1/5.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
/**
 * 计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 真实占用的宽高
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
