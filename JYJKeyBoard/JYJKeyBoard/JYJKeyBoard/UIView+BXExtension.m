//
//  UIView+BXExtension.m
//  JYJKeyBoard
//
//  Created by JYJ on 16/7/18.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "UIView+BXExtension.h"

@implementation UIView (BXExtension)
/**
 *  输出所有子控件
 */
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName {
    // 递归出口
    if ([view isKindOfClass:NSClassFromString(clazzName)]) {
        return view;
    }
    // 遍历所有子视图
    for (UIView *subView in view.subviews) {
        UIView *foundView = [self ff_foundViewInView:subView clazzName:clazzName];
        if (foundView) {
            return foundView;
        }
    }
    return nil;
}
@end
