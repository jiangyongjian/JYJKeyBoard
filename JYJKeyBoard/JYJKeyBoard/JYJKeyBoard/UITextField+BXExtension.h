//
//  UITextField+BXExtension.h
//  JYJKeyBoard
//
//  Created by JYJ on 16/7/14.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BXExtension)
- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange) range;
@end
