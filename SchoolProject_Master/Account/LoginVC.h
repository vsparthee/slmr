//
//  LoginVC.h
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
- (IBAction)action_Login:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtUserName;

@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *changeLangbtn;

@end
