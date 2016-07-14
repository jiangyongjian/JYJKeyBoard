//
//  ViewController.m
//  JYJKeyBoard
//
//  Created by JYJ on 16/7/14.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+BXExtension.h"

@interface ViewController ()
/** button */
@property (nonatomic, weak) UIButton *button;
/** X按钮 */
@property (nonatomic, strong) UIButton *doneButton;
/** 文本框 */
@property (weak, nonatomic) IBOutlet UITextField *textField;
/** 文本框 */
@property (nonatomic, weak) UITextField * txt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44 , self.view.frame.size.width, 44)];
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.button = button;
    
    //  注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    // 动画时间
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 键盘的Frame
    CGRect kbEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbEndFrame.size.height;
    // 动画的轨迹
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    // 按钮的位置计算
    CGFloat doneButtonX = 0;
    CGFloat doneButtonW = 0;
    CGFloat doneButtonH = 0;
    // 为了适配不同屏幕
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 6) / 3;
        doneButtonH = (kbHeight - 2) / 4;
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 8) / 3;
        doneButtonH = (kbHeight - 2) / 4;
    } else if ([UIScreen mainScreen].bounds.size.width == 414) {
        doneButtonW = ([UIScreen mainScreen].bounds.size.width - 7) / 3;
        doneButtonH = kbHeight / 4;
    }
    CGFloat doneButtonY = [UIScreen mainScreen].bounds.size.height + kbHeight - doneButtonH;
#warning TODO 设置按钮要用initWithFrame来创建，不能用init创建，不然按钮会从屏幕上方飞下来
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(doneButtonX, doneButtonY, doneButtonW, doneButtonH)];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:27];
    [doneButton setTitle:@"X" forState:(UIControlStateNormal)];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = doneButton;
   
    // 获取到最上层的window,这句代码很关键
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [tempWindow addSubview:doneButton];

    // 添加动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    doneButton.transform = CGAffineTransformTranslate(doneButton.transform, 0, -kbHeight);
    self.button.transform = CGAffineTransformTranslate(self.button.transform, 0, -kbHeight);
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    // 添加动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    self.doneButton.transform = CGAffineTransformIdentity;
    self.button.transform = CGAffineTransformIdentity;
    [self.doneButton removeFromSuperview];
    [UIView commitAnimations];
}

#pragma mark - 私有方法
/**
 *  完成按钮点击
 */
- (void)doneButton:(UIButton *)doneButton{
    // 获得光标所在的位置
    NSUInteger insertIndex = [self.textField selectedRange].location;
    
    NSMutableString *string = [NSMutableString stringWithString:self.textField.text];
    
    [string insertString:doneButton.currentTitle atIndex:insertIndex];
    
    // 重新赋值
    self.textField.text = string;
    
    // 让光标回到插入文字后面
    [self.textField setSelectedRange:NSMakeRange(insertIndex + 1, 0)];
    
    
    
//    self.textField.text = [self.textField.text stringByAppendingString:doneButton.currentTitle];
}

/**
 *  用颜色返回一张图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)buttonClick {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
