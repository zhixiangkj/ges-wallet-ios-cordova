//
//  MyWebViewController.h
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/11/18.
//  Copyright © 2018 付金亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyWebViewController : CDVViewController
@end

NS_ASSUME_NONNULL_END
@interface MainCommandDelegate : CDVCommandDelegateImpl
@end

@interface MainCommandQueue : CDVCommandQueue
@end
