//
//  UIImage+Extension.m
//  01-QQ聊天
//
//  Created by Apple on 16/1/5.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+(UIImage *)resizableImageWithName:(NSString *)imageName
{
    
    UIImage *norImage = [UIImage imageNamed:imageName];
    CGFloat w = norImage.size.width *0.5 ;
    CGFloat h = norImage.size.height *0.5;
    //        UIImage *newImage = [norImage stretchableImageWithLeftCapWidth:32 topCapHeight:27];
    UIImage *newImage = [norImage  resizableImageWithCapInsets:UIEdgeInsetsMake(h , w , h , w) resizingMode:UIImageResizingModeStretch];
    
    return  newImage;
    
}
@end
