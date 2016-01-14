//
//  NJMessageCell.h
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJMessageModel,NJMessageFrameModel;

@interface NJMessageCell : UITableViewCell
//@property (nonatomic ,strong) NJMessageModel *message;
@property (nonatomic ,strong) NJMessageFrameModel *messageFrame;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
