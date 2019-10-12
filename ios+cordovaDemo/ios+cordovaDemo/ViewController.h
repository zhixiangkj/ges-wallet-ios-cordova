//
//  ViewController.h
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/11/18.
//  Copyright © 2018 付金亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *preventWebView;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;
@property (weak, nonatomic) IBOutlet UITextField *payAmountTF;
- (IBAction)prevent:(id)sender;
- (IBAction)stripePay:(id)sender;
@end

