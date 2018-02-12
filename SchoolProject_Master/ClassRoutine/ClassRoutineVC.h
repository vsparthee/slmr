//
//  ClassRoutineVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 14/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassRoutineVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblClassRoutine;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
- (IBAction)nextAction:(id)sender;
- (IBAction)previousAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nxtbtn;
@property (weak, nonatomic) IBOutlet UIButton *prebtn;
@property (strong, nonatomic) IBOutlet UIView *headerVw;

@end
