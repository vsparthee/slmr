//
//  DashboardVC.h
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblClass;
@property (weak, nonatomic) IBOutlet UILabel *lblExam;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UILabel *lblAttendance;
@property (weak, nonatomic) IBOutlet UILabel *lblHoliday;
@property (weak, nonatomic) IBOutlet UILabel *lblNotice;
@property (weak, nonatomic) IBOutlet UILabel *lblInOut;
@property (weak, nonatomic) IBOutlet UILabel *lblDetails;

@property (strong, nonatomic) UIPickerView *users;
@property (weak, nonatomic) IBOutlet UILabel *selectStudentLbl;


@end
