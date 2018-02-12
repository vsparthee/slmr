//
//  ExamsVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 11/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ExamsVC.h"
#import "ExamsCell.h"
@interface ExamsVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *examListArr;
    NSArray *sectionTitle;
    UILabel *nodata;

}
@end

@implementation ExamsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];

    
    self.tblExams.dataSource = self;
    self.tblExams.delegate = self;
    self.tblExams.separatorStyle = UITableViewCellSeparatorStyleNone;
    sectionTitle = [[NSArray alloc]initWithObjects:@"First Mid Term Exam",@"Quarterly Exam",@"Second Mid Term Exam",@"Half yearly Exam",@"Third Mid Term Exam",@"Annual Exam", nil];
    //[self.tblExams reloadData];
    
    //[self.parent selectrow:3];
    
    /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
     
     [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
     [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];

    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_EXAM_LIST:userDic withSuccess:^(id result)
    {
        if ([result[@"status"]boolValue])
        {
            examListArr = [[NSMutableArray alloc]init];
            examListArr = [result[@"response"]mutableCopy];
            
            if (examListArr.count > 0)
            {
                [nodata removeFromSuperview];
            }
            else
            {
                [self.tblExams addSubview:nodata];
            }
            [self.tblExams reloadData];
        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
        }
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
    return [examListArr count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *tempdic = [examListArr objectAtIndex:section];
    NSArray *temparr = [tempdic valueForKey:@"examSchedule"];
    return temparr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExamsCell" owner:self options:nil];
    ExamsCell *cell = [nib objectAtIndex:0];
    NSDictionary *tempdic = [examListArr objectAtIndex:indexPath.section];
    NSArray *temparr = [tempdic valueForKey:@"examSchedule"];
    NSDictionary *temp = [temparr objectAtIndex:indexPath.row];

    cell.subject.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"subject"]];
    cell.date.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"stDate"]];

    self.tblExams.separatorStyle = UITableViewCellSeparatorStyleNone;
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName = [NSString stringWithFormat:@"%@",[sectionTitle objectAtIndex:section]];
//    return sectionName;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDictionary *tempdic = [examListArr objectAtIndex:section];

    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(16, 4, [UIScreen mainScreen].bounds.size.width, 24);
    myLabel.font = [UIFont fontWithName:THEME_FONT size:16];
    myLabel.text = [NSString stringWithFormat:@"%@",[tempdic valueForKey:@"examTitle"]];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.textColor = [UIColor whiteColor];
    
    UILabel *startLabel = [[UILabel alloc] init];
    startLabel.frame = CGRectMake(16, 32, [UIScreen mainScreen].bounds.size.width, 24);
    startLabel.font = [UIFont fontWithName:THEME_FONT size:14];
    startLabel.text = [NSString stringWithFormat:@"%@ to %@",[tempdic valueForKey:@"examStartDate"],[tempdic valueForKey:@"examEndDate"]];
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.textColor = [UIColor whiteColor];

    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    headerView.backgroundColor = THEME_COLOR;
    [headerView addSubview:myLabel];
    [headerView addSubview:startLabel];

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuAction:(id)sender
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
