//
//  Macros.h
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/12/11.
//  Copyright © 2018 付金亮. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//状态栏高度
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH (SCREEN_RECT.size.width)

#define SCREEN_HEIGHT (SCREEN_RECT.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)
// keyWindow
#define KEY_WINDOW ([UIApplication sharedApplication].keyWindow)
// keyWindow to UIView
#define KEY_VIEW (UIView *)KEY_WINDOW
#endif /* Macros_h */
