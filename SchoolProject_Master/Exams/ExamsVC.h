//
//  ExamsVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 11/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamsVC : UIViewController
@property (weak, nonatomic) LeftMenuVC *parent;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblExams;

@end
