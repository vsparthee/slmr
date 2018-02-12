//
//  NoticeBoardVC.m
//  SchoolProject_Master
//
//  Created by Parthiban on 12/12/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "NoticeBoardVC.h"
#import "NoticeBoardCell.h"
@interface NoticeBoardVC ()<HVTableViewDelegate,HVTableViewDataSource>
{
    NSMutableArray *noticeArr;
    UILabel *nodata;

}
@end

@implementation NoticeBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblNotice.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblNotice.HVTableViewDelegate = self;
    self.tblNotice.HVTableViewDataSource = self;
    self.tblNotice.expandOnlyOneCell = true;
    self.tblNotice.enableAutoScroll = true;
    self.tblNotice.estimatedRowHeight = 2500;
    //self.tblTax.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    
    /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
     
     [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
     [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];

    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];


    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_NOTICE_BOARD:userDic withSuccess:^(id result)
    {
        if ([result[@"status"] boolValue])
        {
            noticeArr = [result[@"response"] mutableCopy];
            
            if (noticeArr.count>0)
            {
                [nodata removeFromSuperview];
            }
            else
            {
                [self.tblNotice addSubview:nodata];
            }
            [self.tblNotice reloadData];

        }
        else
        {
            [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
        }
        [General stopLoader];

        
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        NSLog(@"Error:%@",error.localizedDescription);
        [General stopLoader];
        [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma Mark - Expandable Uitableview

-(void)tableView:(UITableView *)tableView expandCell:(NoticeBoardCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:.5 animations:^{
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    }];
    
}

-(void)tableView:(UITableView *)tableView collapseCell:(NoticeBoardCell *)cell withIndexPath:(NSIndexPath *)indexPat
{
    cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(-M_PI+0.00);
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return noticeArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoticeBoardCell" owner:self options:nil];
    NoticeBoardCell *cell = [nib objectAtIndex:0];
    if (!isExpanded)
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else
    {
        cell.arrowBtn.transform = CGAffineTransformMakeRotation(0);
    }
    NSDictionary *msg = [noticeArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[msg valueForKey:@"newsTitle"]];
    cell.lblDesc.text=[NSString stringWithFormat:@"%@",[msg valueForKey:@"newsText"]];
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
    if(isexpanded)
    {
        return  UITableViewAutomaticDimension;
    }
    
    else
    {
        return 68;
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

@end
