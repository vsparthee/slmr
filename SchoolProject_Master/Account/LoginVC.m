//
//  LoginVC.m
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _txtUserName.text = @"parent1";
    _txtPassword.text = @"123456";
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.changeLangbtn.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.changeLangbtn.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)action_Login:(UIButton *)sender
{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    
    [temp setValue:[NSString stringWithFormat:@"%@",self.txtUserName.text] forKey:@"username"];
    [temp setValue:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"password"];
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];
    [api userLogin:temp withSuccess:^(id result)
    {
        if ([result[@"status"] boolValue]==true)
        {
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setBool:TRUE forKey:@"isLogin"];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            LGSideMenuController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LGSideMenuController"];
            UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
            UIViewController *leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
            [rootViewController setRootViewController:homeVC];
            [rootViewController setLeftViewController:leftMenuVC];
            [rootViewController setLeftViewDisabled:FALSE];
            CGFloat screenWidth = 0.0;
            if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
            {
                screenWidth=[UIScreen mainScreen].bounds.size.height/3;
            }
            else
            {
                screenWidth=[UIScreen mainScreen].bounds.size.width/3;
            }
            rootViewController.leftViewWidth = screenWidth *2.4;
            
            rootViewController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
            [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

            NSDictionary *dic = [result[@"response"] mutableCopy];
            NSArray *arr = [dic valueForKey:@"studentDetails"];
            NSMutableDictionary *userdic = [[NSMutableDictionary alloc]init];
            
            [userdic setValue:[dic valueForKey:@"userId"] forKey:@"userid"];
            [userdic setValue:@"2017-2018" forKey:@"year"];
            if (arr.count>0)
            {
                NSDictionary *student = [arr objectAtIndex:0];
                [userdic setValue:[student valueForKey:@"sudentID"] forKey:@"studentID"];
                [user setObject:[student valueForKey:@"studentName"] forKey:@"studentName"];
                [user setObject:[student valueForKey:@"std"] forKey:@"std"];
                [user setObject:[student valueForKey:@"studentRollid"] forKey:@"studentRollid"];
            }
            NSLog(@"Dic:%@",userdic);
            
            [user setObject:dic forKey:@"userDetails"];
            [user setObject:userdic forKey:@"userdic"];

        }
        else
        {
            [General makeToast:[NSString stringWithFormat:@"%@",result[@"message"]] withToastView:self.view];
        }
        NSLog(@"%@",result);
        [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        NSLog(@"%@",error.localizedDescription);
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

    }];
    
  
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
