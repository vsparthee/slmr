//
//  InOutFullListVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 27/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InOutFullListVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblInOut;
@property (strong, nonatomic) IBOutlet UIView *headerVw;
@property (weak, nonatomic) IBOutlet UILabel *lblmonth;
- (IBAction)nextAction:(id)sender;
- (IBAction)previousAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nxtbtn;
@property (weak, nonatomic) IBOutlet UIButton *prebtn;

@end
