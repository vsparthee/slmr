//
//  AttendanceVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 11/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AttendanceVC.h"
@interface AttendanceVC ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    NSMutableDictionary *fillDefaultColors;
    NSString *yearStart;
    NSMutableArray *monthlyAttendanceArr;
    int objectIndex;
}
@end

@implementation AttendanceVC

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"FSCalendar";
        self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        fillDefaultColors = [[NSMutableDictionary alloc]init];
        NSDictionary *temp = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"attendance"];
        yearStart = [NSString stringWithFormat:@"%@",[temp valueForKey:@"academicYearStart"]];
        NSMutableArray *present = [[temp valueForKey:@"present"] mutableCopy];
        for (int i=0; i<present.count; i++)
        {
            [fillDefaultColors setObject:[UIColor colorWithRed:0.07 green:0.60 blue:0.19 alpha:1.0] forKey:[NSString stringWithFormat:@"%@",[present objectAtIndex:i]]];
        }
        
        
        NSArray *absence = [temp valueForKey:@"absence"];
        for (NSString *date in absence)
        {
            [fillDefaultColors setObject:[UIColor colorWithRed:0.93 green:0.22 blue:0.17 alpha:1.0] forKey:date];
        }
        
        NSArray *holiday = [temp valueForKey:@"holiday"];
        for (NSString *date in holiday)
        {
            [fillDefaultColors setObject:[UIColor colorWithRed:0.95 green:0.61 blue:0.07 alpha:1.0] forKey:date];
        }
        
        monthlyAttendanceArr = [[temp valueForKey:@"attendance"] mutableCopy];
        
     

        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"dd/MM/yyyy";
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    self.calendar.accessibilityIdentifier = @"calendar";
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    self.calendar.allowsSelection = NO;
    self.calendar.appearance.todayColor = [UIColor colorWithRed:0.93 green:0.22 blue:0.17 alpha:1.0];
    
    self.calendar.appearance.titleFont = [UIFont fontWithName:THEME_FONT size:16];
    self.calendar.appearance.headerTitleFont = [UIFont fontWithName:THEME_FONT size:16];
    self.calendar.appearance.weekdayFont = [UIFont fontWithName:THEME_FONT size:16];
    if (monthlyAttendanceArr.count>0)
    {
        objectIndex = (int)monthlyAttendanceArr.count-1;
        [self updateAttendanceFields];
    }

    
}
- (IBAction)previousClicked:(id)sender
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
    NSString * updatedString = [dateFormatter stringFromDate:previousMonth];
    NSLog(@"Output date %@",updatedString);
    self.nextButton.userInteractionEnabled = YES;
    self.nextButton.alpha = 1.0;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *dtOne=[format dateFromString:updatedString];
    
    NSDate *date =[[NSDate alloc] init];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.dateFormat = @"dd/MM/yyyy";
    date = [ dateFormatter1 dateFromString:yearStart];
    
    NSString *stringDate = [format stringFromDate:date];

    NSDate *dtTwo=[format dateFromString:stringDate];
    NSComparisonResult result;
    result = [dtOne compare:dtTwo];
    NSLog(@"Output date %@ vs %@",updatedString,stringDate);

    if(result==NSOrderedSame)
    {
        self.previousButton.userInteractionEnabled = NO;
    self.previousButton.alpha = 0.4;
    }
    else
    {
        NSLog(@"newDate is other");
    }
    objectIndex -=1;
    [self updateAttendanceFields];

}

- (IBAction)nextClicked:(id)sender
{
    self.previousButton.userInteractionEnabled = YES;
    self.previousButton.alpha = 1.0;

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
    NSString * nextString = [dateFormatter stringFromDate:[NSDate date]];
    NSString * currentString = [dateFormatter stringFromDate:nextMonth];
    
    NSLog(@"Output date %@",nextString);
    NSComparisonResult result;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *dtOne=[format dateFromString:currentString];
    NSDate *dtTwo=[format dateFromString:nextString];
    
    result = [dtOne compare:dtTwo];
    if(result==NSOrderedAscending)
        NSLog(@"today is less");
    else if(result==NSOrderedDescending)
        NSLog(@"newDate is less");
    else
        self.nextButton.userInteractionEnabled = NO;
    self.nextButton.alpha = 0.4;
    objectIndex +=1;
    [self updateAttendanceFields];

}

-(void)updateAttendanceFields
{
    NSDictionary *temp = [monthlyAttendanceArr objectAtIndex:objectIndex];
    self.lblNoOfDays.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"numberofdays"]];
    self.lblPresent.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"numberofdayspresent"]];
    self.lblHoliday.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"numberofdaysholiday"]];
    self.lblAbsence.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"numberofdaysabsence"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSString *strToday = [self.dateFormatter  stringFromDate:[NSDate date]];
    return [self.dateFormatter dateFromString:strToday];
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:yearStart];
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *currentMonth = self.calendar.currentPage;
    NSString * nextString = [dateFormatter stringFromDate:[NSDate date]];
    NSString * currentString = [dateFormatter stringFromDate:currentMonth];
    NSComparisonResult result;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *dtOne=[format dateFromString:currentString];
    NSDate *dtTwo=[format dateFromString:nextString];
    
    result = [dtOne compare:dtTwo];
    if(result==NSOrderedAscending)
    {
        self.nextButton.userInteractionEnabled = YES;
        self.nextButton.alpha = 1.0;
    }
    else if(result==NSOrderedDescending)
    {
        NSLog(@"newDate is less");
    }
    else
    {
        self.nextButton.userInteractionEnabled = NO;
        self.nextButton.alpha = 0.4;
    }
    
    
    NSString *key = [self.dateFormatter stringFromDate:date];
    if ([fillDefaultColors.allKeys containsObject:key])
    {
        return fillDefaultColors[key];
    }
    return nil;
}
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    return 0;
}
- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{    // if ([@[@8,@17,@21,@25] containsObject:@([self.gregorian component:NSCalendarUnitDay fromDate:date])]) {    //     return 0.0;    // }
    return 0.0;
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
@end
