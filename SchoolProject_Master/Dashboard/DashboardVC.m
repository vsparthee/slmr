//
//  DashboardVC.m
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableDictionary *fillDefaultColors;
    UIView *bgView;
    NSMutableArray *studentArr;
    NSInteger selectedIndex;

}
@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblTitle.text = [TSLanguageManager localizedString:@"Dashboard"];
    self.lblProfile.text = [TSLanguageManager localizedString:@"Profile"];
    self.lblClass.text = [TSLanguageManager localizedString:@"Class Routine"];
    self.lblExam.text = [TSLanguageManager localizedString:@"Exams"];
    self.lblResult.text = [TSLanguageManager localizedString:@"Results"];
    self.lblAttendance.text = [TSLanguageManager localizedString:@"Attendance"];
    self.lblHoliday.text = [TSLanguageManager localizedString:@"Holiday"];
    self.lblNotice.text = [TSLanguageManager localizedString:@"Notice Board"];
    self.lblInOut.text = [TSLanguageManager localizedString:@"In Out Report"];

    bgView = [[UIView alloc]init];
    NSMutableDictionary * user = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userDetails"] mutableCopy];
    
    studentArr = [user valueForKey:@"studentDetails"];

// Do any additional setup after loading the view.
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.selectStudentLbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"studentName"]];
    self.lblDetails.text = [NSString stringWithFormat:@"%@ - %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"std"],[[NSUserDefaults standardUserDefaults] valueForKey:@"studentRollid"]];
 
    [self attendanceAPI];
    
}

-(void)attendanceAPI
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
    {
        /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
         
         [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
         [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
        NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];
        APIHandler *api = [[APIHandler alloc]init];
        
        [api API_ATTENDANCE:userDic withSuccess:^(id result)
         {
             if ([result[@"status"]boolValue])
             {
                 NSDictionary *temp = [result[@"response"] mutableCopy];
                 [[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"attendance"];
                 NSLog(@"Attendance:%@",fillDefaultColors);
             }
             [General stopLoader];

         }
                    failure:^(NSURLSessionTask *operation, NSError *error)
         {
             [General stopLoader];
         }];

    });
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectExamAction:(UIButton *)sender
{
    UIView *baseview = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-244, [UIScreen mainScreen].bounds.size.width, 244)];
    [baseview setBackgroundColor: [UIColor whiteColor]];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    UIButton *dnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dnBtn setTitle:@"DONE" forState:UIControlStateNormal];
    dnBtn.titleLabel.font = [UIFont fontWithName:THEME_FONT size:16.0];
    dnBtn.frame=CGRectMake(0.0, 0.0, 80.0, 44.0);
    [dnBtn setTitleColor:DARK_BG forState:UIControlStateNormal];
    [dnBtn addTarget:self action:@selector(doneBtnPressToGetValue) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *donebtn =  [[UIBarButtonItem alloc] initWithCustomView:dnBtn];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    toolBar.translucent=NO;
    toolBar.barTintColor=[UIColor lightGrayColor];
    
    [toolBar setItems:[NSArray arrayWithObjects:flexible,donebtn,nil]];
    
    [baseview addSubview:toolBar];
    
    UIPickerView *valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 200)];
    valuePicker.delegate=self;
    valuePicker.dataSource=self;
    valuePicker.showsSelectionIndicator=YES;
    valuePicker.backgroundColor = BG_COLOR;
    [baseview addSubview:valuePicker];
    [bgView addSubview:baseview];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:bgView];
    
}

- (void)doneBtnPressToGetValue
{
    [self updateUI:selectedIndex];
    [bgView removeFromSuperview];
}

-(void)updateUI:(NSInteger)row
{
    NSDictionary *temp = [studentArr objectAtIndex:row];
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userDetails"] mutableCopy];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userdic = [[NSMutableDictionary alloc]init];
    [userdic setValue:[userDic valueForKey:@"userID"] forKey:@"userid"];
    [userdic setValue:@"2017-2018" forKey:@"year"];
    [userdic setValue:[temp valueForKey:@"sudentID"] forKey:@"studentID"];
    [user setObject:[temp valueForKey:@"studentName"] forKey:@"studentName"];
    [user setObject:userdic forKey:@"userdic"];
    [user setObject:[temp valueForKey:@"std"] forKey:@"std"];
    [user setObject:[temp valueForKey:@"studentRollid"] forKey:@"studentRollid"];

    [self attendanceAPI];

}
#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return studentArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(studentArr.count == 0)
    {
        return @"No data available";
    }
    else
    {
        NSDictionary *temp = [studentArr objectAtIndex:row];
        return [temp valueForKey:@"studentName"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *temp = [studentArr objectAtIndex:row];
    self.selectStudentLbl.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"studentName"]];
    self.lblDetails.text = [NSString stringWithFormat:@"%@ - %@",[temp valueForKey:@"std"],[temp valueForKey:@"studentRollid"]];

    selectedIndex = row ;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSString *title;
    if(studentArr.count == 0)
    {
        title =   @"No data available";
    }
    else
    {
        NSDictionary *temp = [studentArr objectAtIndex:row];
        title =  [temp valueForKey:@"studentName"];
    }
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:THEME_FONT size:22]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setTextColor:THEME_COLOR];
        tView.numberOfLines=3;
     /*   selectedIndex = 0;
        NSDictionary *temp = [studentArr objectAtIndex:0];
        self.selectStudentLbl.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"studentName"]];*/
        
    }
    tView.text=title;
    return tView;
}

- (IBAction)action_InOut:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *in_min_str = IN_MIN_TIME;
    NSString *in_max_str = IN_MAX_TIME;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
    
    int in_min   = [self minutesSinceMidnight:[formatter dateFromString:in_min_str]];
    int in_max  = [self minutesSinceMidnight:[formatter dateFromString:in_max_str]];
    int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];
    
    NSString *out_min_str = OUT_MIN_TIME;
    NSString *out_max_str = OUT_MAX_TIME;
    
    int out_min   = [self minutesSinceMidnight:[formatter dateFromString:out_min_str]];
    int out_max  = [self minutesSinceMidnight:[formatter dateFromString:out_max_str]];
    
    if (in_min <= nowTime && nowTime <= in_max && [[defaults valueForKey:@"isIN"]boolValue]==NO)
    {
        [self performSegueWithIdentifier:@"in_out" sender:self];
    }
    else if (out_min <= nowTime && nowTime <= out_max && [[defaults valueForKey:@"isOUT"]boolValue]==NO)
    {
        [self performSegueWithIdentifier:@"in_out" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"in_out_report" sender:self];
    }
    
   
}
-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}
@end
