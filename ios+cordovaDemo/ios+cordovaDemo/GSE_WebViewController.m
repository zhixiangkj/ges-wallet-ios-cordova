//
//  GSE_WebViewController.m
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/12/12.
//  Copyright © 2018 付金亮. All rights reserved.
//

#import "GSE_WebViewController.h"
#import <WebKit/WKWebView.h>
#import "ios_cordovaDemo-Swift.h"
@interface GSE_WebViewController ()
<UINavigationControllerDelegate>
@end

@implementation GSE_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    WKWebView *wkWV = (WKWebView *)self.webView;
    wkWV.frame = CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT + STATUS_BAR_HEIGHT);
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}


@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
 in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}
@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
 in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}
@end
