//
//  UIView+BXExtension.h
//  JYJKeyBoard
//
//  Created by JYJ on 16/7/18.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BXExtension)
/// 查找子视图且不会保存
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;
@end
