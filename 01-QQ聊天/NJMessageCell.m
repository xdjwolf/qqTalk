//
//  NJMessageCell.m
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//
#import "NJMessageFrameModel.h"
#import "NJMessageModel.h"
#import "NJMessageCell.h"
#import "UIImage+Extension.h"
@interface NJMessageCell()
@property(nonatomic,weak) UILabel *timeLabel;
@property(nonatomic,weak) UIButton *contentBtn;
@property(nonatomic,weak) UIImageView *iconView;

@end

@implementation NJMessageCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *identifier = @"message";
    NJMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NJMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(void)setMessageFrame:(NJMessageFrameModel *)messageFrame
{
    _messageFrame = messageFrame;
    //0.获取数据模型
    NJMessageModel *message  = _messageFrame.message;
    //1.设置时间
    self.timeLabel.text = message.time;
    self.timeLabel.frame = _messageFrame.timeF;
    //2,设置头像
    if (NJMessageModelTypeMe == message.type) {
        self.iconView.image = [UIImage imageNamed:@"me"];
        
    }else
    {
        self.iconView.image = [UIImage imageNamed:@"other"];
    }
    self.iconView.frame = _messageFrame.iconF;
   
    //3,设置正文
    [self.contentBtn setTitle:message.text forState:UIControlStateNormal];
    self.contentBtn.frame =_messageFrame.textF;
    //4.设置背景图片
    UIImage *newImage = nil;
    if (NJMessageModelTypeMe == message.type) {
        //自己发的
//        UIImage *norImage = [UIImage imageNamed:@"chat_send_nor"];
        /**
         *  该方法可以返回一张拉伸指定位置的图片
         *LeftCapWidth 左边多大的距离不可被拉伸（水平方向）
         topCapWidth 上边多大的距离不可被拉伸(垂直方向)
         */
        //right cap is calculated as width - leftCapWidth - 1
        //default is 0. if non-zero, vert. stretchable. bottom cap is calculated as height - topCapWidth - 1
        // 128    112       64 * 56   ios 5 之前实现指定拉伸图片某个位置的方法
//        UIImage *newImage =  [norImage stretchableImageWithLeftCapWidth:32 topCapHeight:28];
          //ios 5
//        //指定图片的上边，下边和左边，右边，多少距离是不可以拉伸的     默认的拉伸方案是平铺
//        CGFloat w = norImage.size.width;
//        CGFloat h = norImage.size.height;
////        UIImage *newImage  = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5 -1, w *0.5 -1, h * 0.5, w *0.5)];
//        //ios6  相比ios5的方法，多了一个指定拉伸模式的参数，参数有俩种：平铺，拉伸
//        UIImage *newImage = [norImage  resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5 -1, w *0.5 -1, h * 0.5, w *0.5) resizingMode:UIImageResizingModeStretch];
//        [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];
  
        
        //[self.contentBtn setBackgroundImage:[self resizableImageWithName:@"chat_send_nor"] forState:UIControlStateNormal];
        newImage = [UIImage resizableImageWithName:@"chat_send_nor"];
//        [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];
    }else
    {
            //别人发的
        newImage = [UIImage resizableImageWithName:@"chat_recive_nor"];
//    [self.contentBtn setBackgroundImage:[self resizableImageWithName:@"chat_recive_nor"] forState:UIControlStateNormal];
//        [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];

    }
    [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];
}
//分类 是在不改变原有类的情况下为原有类，增加一些新的方法
//-(UIImage *)resizableImageWithName:(NSString *)imageName
//{
//    
//    UIImage *norImage = [UIImage imageNamed:imageName];
//    CGFloat w = norImage.size.width *0.5 ;
//    CGFloat h = norImage.size.height *0.5;
//    //        UIImage *newImage = [norImage stretchableImageWithLeftCapWidth:32 topCapHeight:27];
//    UIImage *newImage = [norImage  resizableImageWithCapInsets:UIEdgeInsetsMake(h , w , h , w) resizingMode:UIImageResizingModeStretch];
//    
//    return  newImage;
//   
//}
//为了让类创建出来就拥有某些属性
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1，添加将来有可能用到的子控件
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        //正文
        UIButton *contentBtn = [[UIButton alloc]init];
        contentBtn.titleLabel.font = NJTextFont;
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置自动换行
        contentBtn.titleLabel.numberOfLines = 0;
//        contentBtn.backgroundColor = [UIColor redColor];
//        contentBtn.titleLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:contentBtn];
        
        self.contentBtn = contentBtn;
        //头像
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        //清空cell的背景颜色
        self.backgroundColor = [UIColor clearColor];
        //5,设置按钮的内边距
        /**
         *  @param top#>    <#top#> description#>
         *  @param left#>   <#left#> description#>
         *  @param bottom#> <#bottom#> description#>
         *  @param right#>  <#right#> description#>
         */
        self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(NJEdgeInsetsWidth, NJEdgeInsetsWidth, NJEdgeInsetsWidth, NJEdgeInsetsWidth);
        
    }
    return self;
    
}
@end
