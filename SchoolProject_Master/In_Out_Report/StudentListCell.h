//
//  StudentListCell.h
//  SchoolProject_Master
//
//  Created by Parthiban on 10/01/18.
//  Copyright © 2018 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
@interface StudentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkbox;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
