//
//  NJMessageModel.h
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJGlobal.h"
typedef enum
{
    NJMessageModelTypeMe = 0,
    NJMessageModelTypeOther
}NJMessageModelType;

@interface NJMessageModel : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;
/**
 *  是否影藏时间  YES 影藏 
 */
@property(nonatomic,assign)BOOL hiddenTime;
/**
 *  消息类型（YES 其他人发的）
 */
@property (nonatomic,assign) NJMessageModelType type;

NJInitH(messageModel)


@end
