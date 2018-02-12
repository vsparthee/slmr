//
//  AttendanceVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 11/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface AttendanceVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
//@property (strong, nonatomic) NSMutableDictionary *fillDefaultColors;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *lblPresent;
@property (weak, nonatomic) IBOutlet UILabel *lblAbsence;
@property (weak, nonatomic) IBOutlet UILabel *lblHoliday;
@property (weak, nonatomic) IBOutlet UILabel *lblNoOfDays;

@end
