//
//  HolidaysVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 11/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "HolidaysVC.h"
#import "ExamsCell.h"
@interface HolidaysVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *leaveArr;
    UILabel *nodata;

}

@end

@implementation HolidaysVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];

    self.tblHolidays.dataSource = self;
    self.tblHolidays.delegate = self;
    self.tblHolidays.separatorStyle = UITableViewCellSeparatorStyleNone;
    //sectionTitle = [[NSArray alloc]initWithObjects:@"First Mid Term Exam",@"Quarterly Exam",@"Second Mid Term Exam",@"Half yearly Exam",@"Third Mid Term Exam",@"Annual Exam", nil];
   //
    /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
     
     [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
     [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];

    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"demo"]);
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_HOLIDAY:userDic withSuccess:^(id result)
    {
        if ([result[@"status"]boolValue])
        {
            leaveArr = [result[@"response"] mutableCopy];
            if (leaveArr.count > 0)
            {
                [nodata removeFromSuperview];
            }
            else
            {
                [self.tblHolidays addSubview:nodata];
            }

        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

        }
        [self.tblHolidays reloadData];
        [General stopLoader];

    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return leaveArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *temp = [leaveArr objectAtIndex:section];
    NSArray *tempArr = [temp valueForKey:@"holiday"];
    
    return tempArr.count>0?tempArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExamsCell" owner:self options:nil];
    ExamsCell *cell = [nib objectAtIndex:0];
    
    NSDictionary *tempdic = [leaveArr objectAtIndex:indexPath.section];
    NSArray *temparr = [tempdic valueForKey:@"holiday"];
    if (temparr.count>0)
    {
        NSDictionary *temp = [temparr objectAtIndex:indexPath.row];
        
        cell.subject.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"title"]];
        cell.date.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"date"]];

    }
    else
    {
        cell.subject.text = [NSString stringWithFormat:@"No Leaves"];
        cell.date.text = [NSString stringWithFormat:@""];
    }

    
    self.tblHolidays.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row%2==0)
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor=BG_COLOR;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(16, 8, [UIScreen mainScreen].bounds.size.width-32, 24);
    myLabel.font = [UIFont fontWithName:THEME_FONT size:18];
    myLabel.textAlignment = NSTextAlignmentCenter;

    NSDictionary *temp = [leaveArr objectAtIndex:section];

    myLabel.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"month"]];
    [myLabel setTextColor:[UIColor whiteColor]];
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    headerView.backgroundColor = THEME_COLOR;
    [headerView addSubview:myLabel];
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 8);
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0;
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
