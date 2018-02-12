//
//  LeftMenuVC.m
//  CIC
//
//  Created by PPT-MAC-001 on 08/03/17.
//  Copyright © 2017 PPT-MAC-001. All rights reserved.
//

#import "LeftMenuVC.h"
#import "LeftMenuCell.h"
#import "ProfileVC.h"
#import "ExamResultsVC.h"
#import "ExamsVC.h"
#import "AttendanceVC.h"
#import "HolidaysVC.h"
#import "NoticeBoardVC.h"
#import "ClassRoutineVC.h"
#import "InOutReportVC.h"
#import "InOutFullListVC.h"
#import "PrivateMessage.h"
@interface LeftMenuVC ()
{
    NSArray *titleArry,*imageArry;
    ProfileVC *profile;
    ExamResultsVC *result;
    ExamsVC *exam;
    AttendanceVC *attendance;
    HolidaysVC *holiday;
    NoticeBoardVC *notice;
    ClassRoutineVC *routine;
    InOutReportVC *in_out;
    InOutFullListVC *report;
    PrivateMessage *message;
}
@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
}


-(void)setupVC
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
    
    titleArry = [[NSArray alloc]initWithObjects:[TSLanguageManager localizedString:@"Home"],[TSLanguageManager localizedString:@"Message"],[TSLanguageManager localizedString:@"Profile"],[TSLanguageManager localizedString:@"Class Routine"],[TSLanguageManager localizedString:@"Exams"],[TSLanguageManager localizedString:@"Results"],[TSLanguageManager localizedString:@"Attendance"], [TSLanguageManager localizedString:@"Holiday"],[TSLanguageManager localizedString:@"Notice Board"],[TSLanguageManager localizedString:@"In Out Report"],[TSLanguageManager localizedString:@"Logout"], nil];
    
   imageArry = [[NSArray alloc]initWithObjects:@"home",@"message",@"profile", @"class_routine", @"exam",@"results",@"attendance",@"holiday",@"notice", @"in_out",@"logout", nil];
    [self.tableView reloadData];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    profile = [storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    exam = [storyboard instantiateViewControllerWithIdentifier:@"ExamsVC"];
    result = [storyboard instantiateViewControllerWithIdentifier:@"ExamResultsVC"];
    attendance = [storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
    holiday = [storyboard instantiateViewControllerWithIdentifier:@"HolidaysVC"];
    notice = [storyboard instantiateViewControllerWithIdentifier:@"NoticeBoardVC"];
    routine = [storyboard instantiateViewControllerWithIdentifier:@"ClassRoutineVC"];
    in_out = [storyboard instantiateViewControllerWithIdentifier:@"InOutReportVC"];
    report = [storyboard instantiateViewControllerWithIdentifier:@"InOutFullListVC"];
    message = [storyboard instantiateViewControllerWithIdentifier:@"PrivateMessage"];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    LeftMenuCell *cell = (LeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[LeftMenuCell alloc]init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuTitle.text = [titleArry objectAtIndex:indexPath.row];
    cell.menuImg.image = [UIImage imageNamed:[imageArry objectAtIndex:indexPath.row]];
    cell.menuImg.tintColor = BG_COLOR;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   
    if(indexPath.row == 0)
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 1)
    {
        [self.sideMenuController setRootViewController:message];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 2)
    {
        [self.sideMenuController setRootViewController:profile];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 3)
    {
        [self.sideMenuController setRootViewController:routine];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 4)
    {
        [self.sideMenuController setRootViewController:exam];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 5)
    {
        [self.sideMenuController setRootViewController:result];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 6)
    {
        [self.sideMenuController setRootViewController:attendance];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 7)
    {
        [self.sideMenuController setRootViewController:holiday];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 8)
    {
        [self.sideMenuController setRootViewController:notice];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 9)
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
            [self.sideMenuController setRootViewController:in_out];
            [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
        }
        else if (out_min <= nowTime && nowTime <= out_max && [[defaults valueForKey:@"isOUT"]boolValue]==NO)
        {
            [self.sideMenuController setRootViewController:in_out];
            [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
        }
        else
        {
            [self.sideMenuController setRootViewController:report];
            [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
        }


    }
    if(indexPath.row == 10)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"School_Project"
                                                                       message:@"Do you want logout?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action)
                                                              {
                                                                  [self logout];
                                                              }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               }];
        
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"ar"])
    {
        [self.sideMenuController hideRightViewAnimated:YES completionHandler:nil];
    }
    
}
-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}
-(void)logout
{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LGSideMenuController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LGSideMenuController"];
    UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNC"];
    UIViewController *leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    [rootViewController setRootViewController:homeVC];
    [rootViewController setLeftViewController:leftMenuVC];
    [rootViewController setLeftViewDisabled:true];
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
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"setpwd"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profileImage"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"studentName"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userDetails"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userdic"];
}




- (IBAction)homeAction:(id)sender {
    
  
    [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Login"])
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"WalkthroughNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];

    }
    else{
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    */
}


@end
