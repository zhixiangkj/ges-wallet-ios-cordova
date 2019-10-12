/********* GseWallet.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>
#import "ios_cordovaDemo-Swift.h"

@interface GseWallet : CDVPlugin {
  // Member variables go here.
}

// gse钱包支付功能
- (void)pay:(CDVInvokedUrlCommand*)command;
// 关闭访问本网页的浏览器
- (void)closeWebView:(CDVInvokedUrlCommand*)command;
// 定位服务用户是否授权
- (void)isLocationAuthorized:(CDVInvokedUrlCommand*)command;

@end

@implementation GseWallet

- (void)pay:(CDVInvokedUrlCommand*)command
{
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        NSDictionary *params = [JSON parseWithDictStr: echo];
        NSNumber *amount = params[@"paymentAmount"];
        if (amount == nil || ![amount isKindOfClass:[NSNumber class]]) {
            NSString *errorMsg = amount == nil ? @"Field paymentAmount is missing" : @"Field paymentAmount is a number";
            [self.viewController.view makeToast: errorMsg];
            CDVPluginResult* error = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:error callbackId:command.callbackId];
            return;
        }
        NSString *country = params[@"paymentCountry"];
        NSString *currency = params[@"paymentCurrency"];
        [[GSE_Pay shared] popupPayViewWithAmount:[amount doubleValue] country:country currency:currency attachView:self.viewController.view completion:^(GSE_PayStatus status, NSDictionary *paymentInfo) {
            NSString *msg = nil;
            switch (status) {
                case GSE_PayStatusSuccess:
                    msg = @"Pay for success";
                    break;
                case GSE_PayStatusCancel:
                    msg = @"Pay for cancel";
                    break;
                case GSE_PayStatusError:
                    msg = @"Pay for error";
                    break;
                default:
                    msg = @"";
                    break;
            }
            NSMutableDictionary *callbackData = [NSMutableDictionary dictionaryWithDictionary: @{@"code": [NSNumber numberWithInt:status], @"msg": msg}];
            
            if (paymentInfo == nil) {
                paymentInfo = @{};
            }
            [callbackData setObject:paymentInfo forKey:@"data"];
            NSString *callbackDataStr = [JSON stringifyWithDict:callbackData];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:callbackDataStr];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult* error = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:error callbackId:command.callbackId];
    }
}
- (void)closeWebView:(CDVInvokedUrlCommand*)command {
    [self.viewController.navigationController popViewControllerAnimated:YES];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"webView closed"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
// 定位服务用户是否授权
- (void)isLocationAuthorized:(CDVInvokedUrlCommand*)command {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    CDVPluginResult* pluginResult = nil;
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) { // 定位未授权
       pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    } else { // 定位授权
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"location is authorized"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
