# JYJKeyBoard
身份证输入键盘

# GIF
![JYJKeyBoard](GIF/JYJKeyBoard.gif "JYJKeyBoard")

# message
 `JYJKeyBoard` 用数字键盘输入身份证X

# Usage
 `JYJKeyBoard` 很简单，利用系统的键盘，省去自定义的麻烦
```
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
```

# 联系我
 QQ 453255376, 如有bug、不明白的，希望大家踊跃联系我，把程序写的更好。
 
