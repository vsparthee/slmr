//
//  InOutReportVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 12/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InOutReportVC : UIViewController 
@property (weak, nonatomic) IBOutlet UIButton *skipbtn;
@property (weak, nonatomic) IBOutlet UIButton *inOutbtn;
- (IBAction)action_In_Out:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIView *studentListVw;
@property (weak, nonatomic) IBOutlet UITableView *tblStudent;
- (IBAction)action_Cancel:(UIButton *)sender;
- (IBAction)action_Send:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@end
