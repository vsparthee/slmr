//
//  ProfileVC.m
//  SchoolProject_Master
//
//  Created by Rishi on 11/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.profileImg.layer setCornerRadius:64.0f];
    [self.profileImg.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.profileImg.layer setBorderWidth:1.5f];
    [self.profileImg.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.profileImg.layer setShadowOpacity:0.8];
    [self.profileImg.layer setShadowRadius:3.0];
    [self.profileImg.layer setShadowOffset:CGSizeMake(1.0, 5.0)];
    self.profileImg.clipsToBounds = YES;
    
    self.lblTitle.text = [TSLanguageManager localizedString:@"Profile"];
    self.lblClass.text = [TSLanguageManager localizedString:@"Class"];
    self.lblStudentID.text = [TSLanguageManager localizedString:@"Student ID"];
    self.lblDOB.text = [TSLanguageManager localizedString:@"Date of Birth"];
    self.lblGender.text = [TSLanguageManager localizedString:@"Gender"];
    self.lblReligion.text = [TSLanguageManager localizedString:@"Religion"];
    self.lblCountry.text = [TSLanguageManager localizedString:@"Country"];
    self.lblBloodGroup.text = [TSLanguageManager localizedString:@"Blood Group"];
    
    /*
    self.name.text = @"يجعليجعل";
    self.stdclass.text = @"أى";
    self.gender.text = @"الذكر";
    self.religion.text = @"مسلم";
    self.country.text = @"سودي أربية";
    self.bloodgroup.text = @"o + و";
    */

    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.temp.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.temp.layer.mask = maskLayer;
    
    
    
    /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
     
     [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
     [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];


    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_PROFILE:userDic withSuccess:^(id result)
    {
        if ([result[@"status"] boolValue])
        {
            NSDictionary *temp = [result valueForKey:@"response"];
            self.name.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"name"]];
            self.stdclass.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"class"]];
            self.sudentID.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"studentRollid"]];
            self.DOB.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"birthday"]];
            self.gender.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"gender"]];
            self.country.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"address"]];
            self.religion.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"mobileNo"]];
        }
        else
        {
            [General makeToast:[NSString stringWithFormat:@"%@",result[@"message"]] withToastView:self.view];
        }
        [General stopLoader];
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuAction:(id)sender
{
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"ar"])
    {
        [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];
    }
    else
    {
        [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    }
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
