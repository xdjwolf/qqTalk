//
//  NSString+Extension.m
//  01-QQ聊天
//
//  Created by Apple on 16/1/5.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName:font};
    //    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textSize =    [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

@end
