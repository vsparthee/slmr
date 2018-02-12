//
//  LeftMenuVC.h
//  CIC
//
//  Created by PPT-MAC-001 on 08/03/17.
//  Copyright © 2017 PPT-MAC-001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArry;
@property (strong, nonatomic) NSArray *imageArry;
- (IBAction)homeAction:(id)sender;
-(void)setupVC;
@end
