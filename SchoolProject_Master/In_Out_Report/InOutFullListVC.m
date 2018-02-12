//
//  InOutFullListVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 27/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "InOutFullListVC.h"
#import "InOutFullListCell.h"
@interface InOutFullListVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *inoutArr,*monthinoutArr;
    NSMutableDictionary *monthlyDic;
    NSInteger selectedIndex;
    UILabel *nodata;

}
@end

@implementation InOutFullListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];

    
    self.tblInOut.dataSource = self;
    self.tblInOut.delegate = self;
    self.tblInOut.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];
    
    
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_IN_OUT_REPORT:userDic withSuccess:^(id result)
     {
         if ([result[@"status"]boolValue])
         {
             inoutArr = [[NSMutableArray alloc]init];
             inoutArr = [result[@"response"] mutableCopy];
             if (inoutArr.count >0)
             {
                 monthlyDic = [inoutArr objectAtIndex:inoutArr.count-1];
                 selectedIndex = (NSInteger) inoutArr.count-1;
                 monthinoutArr = [[NSMutableArray alloc]init];
                 monthinoutArr = [monthlyDic valueForKey:@"inoutReport"];
                 self.lblmonth.text = [monthlyDic objectForKey:@"month"];
                 [self.nxtbtn setHidden:true];
                 if (monthinoutArr.count>0)
                 {
                     [nodata removeFromSuperview];
                 }
                 else
                 {
                     [self.tblInOut addSubview:nodata];
                 }
             }
             else
             {
                 [self.tblInOut addSubview:nodata];
             }
         }
         else
         {
             [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

         }
         [self.tblInOut reloadData];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return monthinoutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InOutFullListCell" owner:self options:nil];
    InOutFullListCell *cell = [nib objectAtIndex:0];
    
    NSDictionary *temp = [monthinoutArr objectAtIndex:indexPath.row];
        
    cell.inTime.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"inTime"]];
    cell.date.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"date"]];
    cell.outTime.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"outTime"]];

    self.tblInOut.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    return self.headerVw;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)nextAction:(id)sender
{
    if (selectedIndex < (inoutArr.count-1))
    {
        selectedIndex +=1;
        monthlyDic = [inoutArr objectAtIndex:selectedIndex];
        self.lblmonth.text = [monthlyDic objectForKey:@"month"];
        monthinoutArr = [[NSMutableArray alloc]init];
        monthinoutArr = [monthlyDic objectForKey:@"inoutReport"];
        
        
        if (monthinoutArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            [self.tblInOut addSubview:nodata];
        }
        
        [self.tblInOut reloadData];
        
        
        if (selectedIndex == (inoutArr.count-1))
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
        monthlyDic = [inoutArr objectAtIndex:selectedIndex];
        self.lblmonth.text = [monthlyDic objectForKey:@"month"];
        monthinoutArr = [[NSMutableArray alloc]init];
        monthinoutArr = [monthlyDic objectForKey:@"inoutReport"];
        
        
        if (monthinoutArr.count>0)
        {
            [nodata removeFromSuperview];
        }
        else
        {
            [self.tblInOut addSubview:nodata];
        }
        [self.tblInOut reloadData];
        
        
        if (selectedIndex == 0)
        {
            [self.prebtn setHidden:true];
        }
        else
        {
            [self.prebtn setHidden:false];
        }
        
        if (selectedIndex < (inoutArr.count-1))
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
