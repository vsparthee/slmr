//
//  ClassRoutineVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 14/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ClassRoutineVC.h"
#import "ClassRoutineCell.h"
@interface ClassRoutineVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *weeklyscheduleArr;
    NSMutableDictionary *dayScheduleDic;
    NSMutableArray *dayscheduleArr;
    int selectedIndex;
    UILabel *nodata;

}
@end

@implementation ClassRoutineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];

   /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
    
    [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
    [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_CLASS_SCHUDULE:userDic withSuccess:^(id result)
    {
        if ([result[@"status"] boolValue])
        {
            weeklyscheduleArr = [[NSMutableArray alloc]init];
            weeklyscheduleArr = [result[@"response"] mutableCopy];
            if (weeklyscheduleArr.count >0)
            {
                [self.lblDay setHidden:false];
                [self.prebtn setHidden:false];
                [self.nxtbtn setHidden:false];

                [self.prebtn setHidden:true];
                dayScheduleDic = [weeklyscheduleArr objectAtIndex:0];
                selectedIndex = 0;
                self.lblDay.text = [dayScheduleDic objectForKey:@"day"];
                dayscheduleArr = [[NSMutableArray alloc]init];
                dayscheduleArr = [dayScheduleDic objectForKey:@"details"];
                if (dayscheduleArr.count>0)
                {
                    [nodata removeFromSuperview];
                }
                else
                {
                    [self.tblClassRoutine addSubview:nodata];
                }
            }
            else
            {
                [self.lblDay setHidden:true];
                [self.prebtn setHidden:true];
                [self.nxtbtn setHidden:true];
                [self.tblClassRoutine addSubview:nodata];

            }
            [self.tblClassRoutine reloadData];

        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
        }
        [General stopLoader];
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [self.lblDay setHidden:true];
        [self.prebtn setHidden:true];
        [self.nxtbtn setHidden:true];
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dayscheduleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassRoutineCell" owner:self options:nil];
    ClassRoutineCell *cell = [nib objectAtIndex:0];
    
    self.tblClassRoutine.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *temp = [dayscheduleArr objectAtIndex:indexPath.row];
    
    cell.subject.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"subject"]];
    cell.time.text = [NSString stringWithFormat:@"%@ to %@",[temp objectForKey:@"startTime"],[temp objectForKey:@"endTime"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.headerVw;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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

- (IBAction)nextAction:(id)sender
{
    if (selectedIndex < (weeklyscheduleArr.count-1))
    {
        selectedIndex +=1;
        dayScheduleDic = [weeklyscheduleArr objectAtIndex:selectedIndex];
        self.lblDay.text = [dayScheduleDic objectForKey:@"day"];
        dayscheduleArr = [[NSMutableArray alloc]init];
        dayscheduleArr = [dayScheduleDic objectForKey:@"details"];
        
        
        if (dayscheduleArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            [self.tblClassRoutine addSubview:nodata];
        }
        
        [self.tblClassRoutine reloadData];
        
        
        if (selectedIndex == (weeklyscheduleArr.count-1))
        {
            [self.nxtbtn setHidden:true];
        }
        else
        {
            [self.nxtbtn setHidden:false];
        }
        
        if (selectedIndex > 0)
        {
            [self.prebtn setHidden:false];
        }
        else
        {
            [self.prebtn setHidden:true];
        }


    }
}

- (IBAction)previousAction:(id)sender
{
    if (selectedIndex > 0)
    {
        selectedIndex -=1;
        dayScheduleDic = [weeklyscheduleArr objectAtIndex:selectedIndex];
        self.lblDay.text = [dayScheduleDic objectForKey:@"day"];
        dayscheduleArr = [[NSMutableArray alloc]init];
        dayscheduleArr = [dayScheduleDic objectForKey:@"details"];
        
        
        if (dayscheduleArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            [self.tblClassRoutine addSubview:nodata];
        }
        [self.tblClassRoutine reloadData];
        
        
        if (selectedIndex == 0)
        {
            [self.prebtn setHidden:true];
        }
        else
        {
            [self.prebtn setHidden:false];
        }
        
        if (selectedIndex < (weeklyscheduleArr.count-1))
        {
            [self.nxtbtn setHidden:false];
        }
        else
        {
            [self.nxtbtn setHidden:true];
        }

    }
}
@end
