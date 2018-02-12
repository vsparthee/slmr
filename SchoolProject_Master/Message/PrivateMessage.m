//
//  PrivateMessage.m
//  SchoolProject_Master
//
//  Created by Parthi on 10/02/18.
//  Copyright © 2018 Parthiban. All rights reserved.
//

#import "PrivateMessage.h"
#import "PrivateMessageCell.h"
@interface PrivateMessage ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *messageList;
    UILabel *nodata;

}
@end

@implementation PrivateMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblMessage.estimatedRowHeight = 2500;
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/3 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:THEME_FONT size:16];
    nodata.textColor = [UIColor whiteColor];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_PRIVATE_MESSAGE:userDic withSuccess:^(id result)
     {
         if ([result[@"status"] boolValue])
         {
             messageList = [result[@"response"] mutableCopy];
             if (messageList.count>0)
             {
                 [nodata removeFromSuperview];
             }
             else
             {
                 [self.tblMessage addSubview:nodata];
             }
             
         }
         else
         {
             [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
         }
        
         
         [self.tblMessage reloadData];
         [General stopLoader];

     }
                     failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [General stopLoader];
         [General makeToast:[TSLanguageManager localizedString:@"Please Try again Later"] withToastView:self.view];
     }];

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrivateMessageCell" owner:self options:nil];
    PrivateMessageCell *cell = [nib objectAtIndex:0];
    
    NSDictionary *tempdic = [messageList objectAtIndex:indexPath.section];
    
    cell.lblMessgae.text = [NSString stringWithFormat:@"%@",[tempdic valueForKey:@"message"]];
    cell.lblDate.text = [NSString stringWithFormat:@"%@",[tempdic valueForKey:@"date"]];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  UITableViewAutomaticDimension;
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
