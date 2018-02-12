//
//  NoticeBoardVC.h
//  SchoolProject_Master
//
//  Created by Parthiban on 12/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableView.h"
@interface NoticeBoardVC : UIViewController
@property (weak, nonatomic) IBOutlet HVTableView *tblNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@end
