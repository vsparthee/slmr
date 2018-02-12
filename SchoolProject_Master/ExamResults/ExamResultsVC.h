//
//  ExamResultsVC.h
//  SchoolProject_Master
//
//  Created by Rishi on 11/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamResultsVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblExam;
@property (weak, nonatomic) IBOutlet UIView *headerView;
- (IBAction)selectExamAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectExamBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectExamLbl;

@property (strong, nonatomic) UIPickerView *exams;
@property (weak, nonatomic) IBOutlet UILabel *markScroed;
@property (weak, nonatomic) IBOutlet UILabel *totalMark;
@property (weak, nonatomic) IBOutlet UILabel *cgp;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
