//
//  NJMessageFrameModel.h
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define NJEdgeInsetsWidth 20
#define NJTextFont   [UIFont systemFontOfSize:15]
@class NJMessageModel;
@interface NJMessageFrameModel : NSObject
/**
 *  数据模型frame
 */
@property (nonatomic ,strong) NJMessageModel *message;
//-(void)setMessage:(NJMessageModel *)message andLastMessage:(NJMessageModel *)message;
//readonly 只能获取，不能设置值
@property(nonatomic,assign,readonly) CGRect timeF;
@property(nonatomic,assign,readonly) CGRect iconF;

@property(nonatomic,assign,readonly) CGRect textF;
/**
 *  cell的高度
 */
@property(nonatomic,assign,readonly) CGFloat cellHeight;

@end
