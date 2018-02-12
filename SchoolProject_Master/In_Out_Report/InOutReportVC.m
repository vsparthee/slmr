//
//  InOutReportVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 12/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "InOutReportVC.h"
#import <CoreLocation/CoreLocation.h>
#import "StudentListCell.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface InOutReportVC ()<CLLocationManagerDelegate,BEMCheckBoxDelegate>
{
    CLLocation *userLocation;
    BEMCheckBoxGroup *group;
    NSMutableArray *studentlist,*studentID;

}
@property(nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation InOutReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.skipbtn.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    self.skipbtn.layer.mask = maskLayer;
    [self updateLocation];
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userDetails"] mutableCopy];
    studentlist = [userDic valueForKey:@"studentDetails"];
    studentID = [[NSMutableArray alloc]initWithCapacity:studentlist.count];
    for (NSDictionary *temp in studentlist)
    {
        [studentID addObject:[temp valueForKey:@"sudentID"]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy - EEEE"];
    self.lblDate.text = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter setDateFormat:@"hh:mm a"];
    self.lblTime.text = [dateFormatter stringFromDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuAction:(UIButton*)sender
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

-(void) updateLocation
{
    if (!self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
}
-(void) locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *) newLocation
           fromLocation: (CLLocation *) oldLocation
{
    double tolongitude = LONGITUTE;
    double tolatitude  = LATITUTE;

    userLocation = newLocation;
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:tolatitude longitude:tolongitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    if (distance < 1200)
    {
        self.inOutbtn.userInteractionEnabled = YES;
        self.inOutbtn.alpha = 1.0;
    }
    else
    {
        self.inOutbtn.userInteractionEnabled = NO;
        self.inOutbtn.alpha = 0.6;
    }

    //[self.locationManager stopUpdatingLocation];
}

-(BOOL)checkUserLocation{
    
    double tolongitude = LONGITUTE;
    double tolatitude  = LATITUTE;

    CLLocation *locA = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:tolatitude longitude:tolongitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    if (distance < 1200)
    {
        return true;
    }
    else
    {
        return false;
    }
}
-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}
-(void)api
{
    if([self checkUserLocation])
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
            if (studentlist.count>1)
            {
                self.studentListVw.frame = [UIScreen mainScreen].bounds;
                [self.view addSubview:self.studentListVw];
            }
            else
            {
                [self student_in_api];
            }
        }
        else if (out_min <= nowTime && nowTime <= out_max && [[defaults valueForKey:@"isOUT"]boolValue]==NO)// && [[defaults valueForKey:@"isIN"]boolValue]==YES)
        {
            if (studentlist.count>1)
            {
                self.studentListVw.frame = [UIScreen mainScreen].bounds;
                [self.view addSubview:self.studentListVw];
            }
            else
            {
                [self student_out_api];
            }
        }
    }
    else
    {
        NSLog(@"outside");
        [General makeToast:@"Your current location is not matched with your service location, Application allows you to perform action within ‘500M’ from your service location. \nTry again!" withToastView:self.view];

        self.inOutbtn.userInteractionEnabled = NO;
        self.inOutbtn.alpha = 0.6;

    }

}


-(void) student_in_api
{
    APIHandler *api = [[APIHandler alloc]init];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
    [General startLoader:self.view];

    [userDic setValue:studentID forKey:@"studentID"];
    [userDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];

    [api API_STUDENT_IN:userDic withSuccess:^(id result)
     {
         if ([result[@"status"]boolValue])
         {
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setBool:YES forKey:@"isIN"];
             [defaults setBool:NO forKey:@"isOUT"];
         }
         else
         {
             [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
         }
         [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

    }];
}

-(void) student_out_api
{
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
    
    [userDic setValue:studentID forKey:@"studentID"];
    [userDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];

    
    [api API_STUDENT_OUT:userDic withSuccess:^(id result)
    {
        if ([result[@"status"]boolValue])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"isOUT"];
            [defaults setBool:NO forKey:@"isIN"];
        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

        }
        [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
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

- (IBAction)action_In_Out:(UIButton *)sender
{
    [self api];
}
- (IBAction)action_Cancel:(UIButton *)sender
{
    [self.studentListVw removeFromSuperview];
}

- (IBAction)action_Send:(UIButton *)sender
{
    if([self checkUserLocation])
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
            [self student_in_api];
        }
        else if (out_min <= nowTime && nowTime <= out_max && [[defaults valueForKey:@"isOUT"]boolValue]==NO)// && [[defaults valueForKey:@"isIN"]boolValue]==YES)
        {
            [self student_out_api];
        }
        [self.studentListVw removeFromSuperview];

    }
    else
    {
        NSLog(@"outside");
        [General makeToast:@"Your current location is not matched with your service location, Application allows you to perform action within ‘500M’ from your service location. \nTry again!" withToastView:self.view];
        
        self.inOutbtn.userInteractionEnabled = NO;
        self.inOutbtn.alpha = 0.6;
        
    }

    
}

#pragma mark - TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return studentlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentListCell" owner:self options:nil];
    StudentListCell *cell = [nib objectAtIndex:0];
    NSDictionary *temp = [studentlist objectAtIndex:indexPath.row];
    
    cell.lblName.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"studentName"]];
    cell.checkbox.tag = (int)indexPath.row;
    cell.checkbox.enabled = NO;
    cell.checkbox.onAnimationType = BEMAnimationTypeBounce;
    cell.checkbox.offAnimationType = BEMAnimationTypeBounce;
    cell.checkbox.boxType = BEMBoxTypeSquare;
    cell.checkbox.tintColor = THEME_COLOR;
    cell.checkbox.onFillColor = THEME_COLOR;
    cell.checkbox.onTintColor = THEME_COLOR;
    cell.checkbox.offFillColor = [UIColor whiteColor];
    cell.checkbox.onCheckColor = [UIColor whiteColor];
    //[cell.checkbox setSelected: YES];
    cell.checkbox.enabled = YES;
    cell.checkbox.delegate=self;
    cell.checkbox.on = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    NSDictionary *temp = [studentlist objectAtIndex:checkBox.tag];
    if (checkBox.isSelected)
    {
        [studentID addObject:[temp valueForKey:@"sudentID"]];
        [checkBox setSelected:NO];
    }
    else
    {
        [studentID removeObject:[temp valueForKey:@"sudentID"]];
        [checkBox setSelected:YES];
    }
    if (studentID.count > 0)
    {
        self.btnSend.userInteractionEnabled = YES;
        self.btnSend.alpha = 1.0;
    }
    else
    {
        self.btnSend.userInteractionEnabled = NO;
        self.btnSend.alpha = 0.6;
    }
}
@end
