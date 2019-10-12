//
//  ViewController.m
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/11/18.
//  Copyright © 2018 付金亮. All rights reserved.
//

#import "ViewController.h"
#import "GSE_WebViewController.h"
#import "ios_cordovaDemo-Swift.h"
#import "GseUtils/UIView+MaskActivity.h"
static NSString * const DEFAULT_ASK_URL = @"http://10.200.101.81:8080";
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    NSString *askUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"askUrl"];
    self.urlTF.text = askUrl.length > 0 ? askUrl : DEFAULT_ASK_URL;
}

- (IBAction)prevent:(id)sender {
    GSE_WebViewController *myWVC = [[GSE_WebViewController alloc]init];
    if (self.urlTF.text.length >0){
        myWVC.wwwFolderName = @"";
        myWVC.startPage = self.urlTF.text;
    };
    [self.navigationController pushViewController:myWVC animated:YES];
    [[NSUserDefaults standardUserDefaults] setObject:self.urlTF.text forKey:@"askUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)stripePay:(id)sender {
    double payAmount = [NSDecimalNumber decimalNumberWithString:self.payAmountTF.text].doubleValue;
    if (isnan(payAmount)) {
        [self.view makeToast:@"您输入的不是数字"];
    } else {
        [self.payAmountTF resignFirstResponder];
        [[GSE_Pay shared] popupPayViewWithAmount:payAmount country:nil currency:nil attachView: self.view completion:^(GSE_PayStatus status, NSDictionary *paymentInfo) {
            NSLog(@"%ld", (long)status);
            NSLog(@"%@", paymentInfo);
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing: YES];
}
@end
