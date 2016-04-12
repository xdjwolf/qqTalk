//
//  ViewController.m
//  01-QQ聊天
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 xidian. All rights reserved.
//

#import "ViewController.h"
#import "NJMessageModel.h"
//#import "NJMessageCell.m"
#import "NJMessageCell.h"
#import "NJMessageFrameModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic ,strong) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
/**
 *  存放所有的自动回复数据
 */
@property (nonatomic ,strong) NSDictionary *autoReplays;

@end

@implementation ViewController
#pragma mark  ---懒加载
-(NSDictionary *)autoReplays
{
    if (_autoReplays == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"autoplay.plist" ofType:nil];
        
        _autoReplays = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return  _autoReplays;
}

- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        //记录上一次的消息模型
//        NJMessageModel *previousMessage = nil;
        
        for (NSDictionary *dict in dictArray) {
            //1, 创建数据模型
            NJMessageModel *message = [NJMessageModel messageModelWithDict:dict];
            //2.获取上一次的数据模型
            NJMessageModel *previousMessage = (NJMessageModel *)[[models lastObject]message];
            //设置是否需要隐藏时间
            message.hiddenTime = [message.time isEqualToString:previousMessage.time];
            //创建Frame模型
            NJMessageFrameModel *mfm = [[NJMessageFrameModel alloc]init];
            mfm.message = message;
                     [models addObject:mfm];
//            previousMessage = message;
        }
        self.messages = [models mutableCopy];
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置影藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置影藏垂直的滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置tableview背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    //设置cell不可以被选中
    self.tableView.allowsSelection = NO;
    //注册键盘尺寸监听的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //给文本输入框添加左边的视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
//    view.backgroundColor = [UIColor redColor];
    self.inputTextField.leftView = view;
    //设置左边视图的显示模式
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
 //监听键盘send 按钮的点击
    self.inputTextField.delegate = self;
    
}

-(void)keyboardWillChange:(NSNotification *)notification
{
    NSLog(@"键盘弹出 %@",notification);
   /* name = UIKeyboardWillChangeFrameNotification; userInfo = {
    //键盘弹出的节奏
        UIKeyboardAnimationCurveUserInfoKey = 7;
    //键盘弹出执行动画的时间
        UIKeyboardAnimationDurationUserInfoKey = "0.25";
        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 694.5}";
        UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 441.5}";
        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
        UIKeyboardIsLocalUserInfoKey = 1;
    }}*/
    //键盘隐藏时的frame
   /* {name = UIKeyboardWillChangeFrameNotification; userInfo = {
        UIKeyboardAnimationCurveUserInfoKey = 7;
        UIKeyboardAnimationDurationUserInfoKey = "0.25";
        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 441.5}";
        UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 694.5}";
        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
        UIKeyboardIsLocalUserInfoKey = 1;*/
    
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
//  UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
    /*弹出时候的Y值*/
    //计算需要移动的距离
    NSDictionary *dict = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    
    //获取动画执行的时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //计算需要移动的距离
     CGFloat translationY = keyboardY - self.view.frame.size.height;
    //通过动画移动view
//    [UIView animateWithDuration:duration animations:^{
//
//    }];
//
    /**
     *  输入框和键盘之间有一条黑色的线条，产生线条的原因是键盘弹出时执行动画的节奏和我们让控制器view移动的动画的节奏不一致导致
     */
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16  animations:^{
        //需要执行动画的代码
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
         //动画执行完毕的代码
    }];

//    self.view.transform = CGAffineTransformMakeTranslation(0, -253);
//    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
}
#pragma mark ---UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   //创建自己发送的消息
    [self addMessages:textField.text type:NJMessageModelTypeMe];
    //创建别人发送的消息
    
    NSString *result = [self autoReplayWithContent:textField.text];
    
//    [self addMessages:result type:NJMessageModelTypeOther];
    [self addMessages:result type:NJMessageModelTypeOther];
    //2，刷新表格
    [self.tableView reloadData];
    //3让tableview滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count -1 inSection:0];
    /**
     *  @param NSIndexPath 要滚动到哪一行
     *(UITableViewScrollPosition) 滚动哪一行的什么位置
     *  @return
     */
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //4,清空输入行
    self.inputTextField.text = nil;
    return YES;
}
/**
 *  传入给定的内容，返回自动回复的内容
 */
-(NSString *)autoReplayWithContent:(NSString *)content
{
    NSString *result = nil;
    //取出用户输入的每一个字
    for (int i = 0; i < content.length; i++) {
        /**
         *  我爱你
         * 0  1  2
         *  @param 0 从哪个字开始截取
         *  @param 1 每次截取的步长
         */
        NSString *str = [content substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@",str);
        result =  self.autoReplays[str];
        if (result != nil) {
            //代表了找到自动回复的内容
            break;
        }
    }
    if (result == nil) {
        result = [NSString stringWithFormat:@"%@你个蛋",content] ;
        
    }
    //    NSString *temp = [NSString stringWithFormat:@"%@你个蛋",textField.text] ;
    //去内存中加载进来的字典中有无可用的回复信息
    return result;
}
/**
 *  添加一条消息
 *
 *  @param content <#content description#>
 *  @param type    <#type description#>
 */
-(void)addMessages:(NSString *)content type:(NJMessageModelType)type
{
    
    //1，修改模型（创建模型，并且将模型保存到数组中）
    
    //获取上一次的message
    NJMessageModel  *previousMessage = (NJMessageModel *)[[self.messages lastObject] message];
    
    NJMessageModel *message = [[NJMessageModel alloc]init];
   //实现把用户发送时的时间，作为发送时间
    NSDate *date = [NSDate date];//创建时间对象
//    NSLog(@"%@",date);
    //可以将时间转换为字符串，也可以将时间转为字符串
    //2014-05-13    2014/12/23 09/04/15
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //时间格式 HH 24h  hh 12h
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.dateFormat = @"HH:mm";
     NSString *time = [formatter stringFromDate:date];
    
//    NSLog(@"%@",time);
    message.time = time;
    message.text = content;
    message.type = type;
    message.hiddenTime = [message.time isEqualToString:previousMessage.time];
    //根据message模型创建frame模型
    NJMessageFrameModel *mf = [[NJMessageFrameModel alloc]init];
    mf.message = message;
    [self.messages addObject:mf];

}
#pragma mark  ___代理方法
//该方法，有多少条数据，就会调用多少次
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    //1,取出frame模型
    NJMessageFrameModel *mf = self.messages[indexPath.row];
    return mf.cellHeight;
    
    //2,返回对应行的高度

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //放弃第一响应
    [self.view endEditing:YES];
    
}

#pragma mark ----数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1，创建cell
//    NSString *identifier = @"message";
//    NJMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[NJMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        
//    }
    NJMessageCell *cell = [NJMessageCell cellWithTableView:tableView];
    //2，设置数据
    cell.messageFrame = self.messages[indexPath.row];
//    cell.message = self.messages[indexPath.row];
    //3，返回cell
    return cell;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
