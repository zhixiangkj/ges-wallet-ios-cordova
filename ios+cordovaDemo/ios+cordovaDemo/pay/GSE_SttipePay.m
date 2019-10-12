//
//  GSE_SttipePay.m
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/12/2.
//  Copyright © 2018 付金亮. All rights reserved.
//

#import "GSE_SttipePay.h"
#import <Stripe.h>
#import "ios_cordovaDemo-Swift.h"
@implementation GSE_SttipePay
static NSString *const publishableKey = @"pk_test_O5N1418rxpxfcnHoklRxZvNJ";
static NSString *const baseURLString = @"http://10.200.101.231:3000";
static NSString *const appleMerchantIdentifier = @"merchant.gse";
static NSString *const companyName = @"Rocket Rides";

static GSE_SttipePay *_instance = nil;

+(instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL]init];
    });
    return _instance;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        STPPaymentConfiguration *payConfig =  [STPPaymentConfiguration sharedConfiguration];
        payConfig.companyName = companyName;
        if (!publishableKey.length) {
            payConfig.publishableKey = publishableKey;
        }
        
        if (!appleMerchantIdentifier.length) {
            payConfig.appleMerchantIdentifier = appleMerchantIdentifier;
        }
        // Main API client configuration
        [MainAPIClient shared].baseURLString = baseURLString;
    }
    return self;
}
+(id) allocWithZone:(struct _NSZone *)zone {
    return [GSE_SttipePay shared];
}
-(id) copyWithZone:(struct _NSZone *)zone {
    return [GSE_SttipePay shared];
}
@end
