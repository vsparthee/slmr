//
//  ProfileVC.h
//  SchoolProject_Master
//
//  Created by Rishi on 11/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStudentID;
@property (weak, nonatomic) IBOutlet UILabel *lblDOB;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblReligion;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblBloodGroup;
@property (weak, nonatomic) IBOutlet UILabel *lblClass;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *stdclass;
@property (weak, nonatomic) IBOutlet UILabel *sudentID;
@property (weak, nonatomic) IBOutlet UILabel *DOB;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *religion;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *bloodgroup;

@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@property (weak, nonatomic) IBOutlet UIButton *temp;

@end
