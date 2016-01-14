//
//  NJMessageFrameModel.m
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import "NJMessageFrameModel.h"
#import "NJMessageModel.h"

#import "NSString+Extension.h"

@implementation NJMessageFrameModel
-(void)setMessage:(NJMessageModel *)message
{
    _message = message;
    //屏幕宽度
    CGFloat screen =     [UIScreen mainScreen].bounds.size.width;
    //间隙
    CGFloat padding = 10;
    //1，时间
    if ( NO == message.hiddenTime) {//是否需要计算时间
            CGFloat timeX = 0;
            CGFloat timeY = 0;
            CGFloat timeH = 30;
            CGFloat timeW = screen;
            _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    //2,头像
    CGFloat iconH = 30;
    CGFloat iconW = 30;
    CGFloat iconX = 0;
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    if (NJMessageModelTypeMe == _message.type ) {
         //x = 屏幕宽度- 间隙 -- 头像宽度
        iconX  = screen - padding - iconW;
          }else{
        //别人发的
        iconX = padding ;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //3, 正文
//    NSDictionary *dict = @{NSFontAttributeName:NJTextFont};
//    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
//   CGSize textSize =    [_message.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    
    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textSize = [_message.text sizeWithFont:NJTextFont maxSize:maxSize];
//    CGSize textSize  = [self sizeWithString:_message.text Font:NJTextFont maxSize:maxSize];
    
    
    CGFloat textW = textSize.width + NJEdgeInsetsWidth *2;
    CGFloat textH = textSize.height + NJEdgeInsetsWidth *2;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    if (NJMessageModelTypeMe == _message.type) {
        //x = 头像X - 间隙 -  文本的宽度
       textX = iconX - padding - textW;
    }else
    {
        //别人发的
        //X = 头像最大的X + 间隙
        textX = CGRectGetMaxX(_iconF) + padding;
    }
    _textF = CGRectMake(textX, textY, textW, textH);
    //4，计算行高
    CGFloat maxIconY = CGRectGetMaxY(_iconF);
    CGFloat maxTextY = CGRectGetMaxY(_textF);
    
//    _cellHeight  = (maxIconY > maxTextY ? (maxIconY + padding) : (maxTextY + padding));
    _cellHeight = MAX(maxIconY, maxTextY) + padding;
}
/*-(CGSize)sizeWithString:(NSString *) str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName:NJTextFont};
//    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textSize =    [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}*/

@end
