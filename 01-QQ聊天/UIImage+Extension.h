//
//  UIImage+Extension.h
//  01-QQ聊天
//
//  Created by Apple on 16/1/5.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  传入图片的名称，返回一张可拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 可拉伸的图片
 */
+(UIImage *)resizableImageWithName:(NSString *)imageName;
@end
