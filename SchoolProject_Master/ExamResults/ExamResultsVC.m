//
//  ExamResultsVC.m
//  SchoolProject_Master
//
//  Created by Rishi on 11/28/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "ExamResultsVC.h"
#import "TableViewCell.h"
@interface ExamResultsVC ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *resultArr,*examTitle,*selectedArr;
    UIView *bgView;
    NSInteger selectedIndex;
    UILabel *nodata;

}
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *circleView;

@end

@implementation ExamResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblExam.dataSource = self;
    self.tblExam.delegate = self;
    self.tblExam.estimatedRowHeight = 2500;
    self.tblExam.rowHeight = 200;
    self.tblExam.rowHeight = UITableViewAutomaticDimension;
    self.tblExam.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tblExam.layer.cornerRadius=10;
    self.tblExam.clipsToBounds=YES;
    bgView = [[UIView alloc]init];

    for (UIView *tempvw in self.circleView)
    {
        tempvw.layer.cornerRadius=46;
        tempvw.clipsToBounds=YES;
    }

    /* NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
     
     [userDic setValue:[NSNumber numberWithInt:5] forKey:@"studentID"];
     [userDic setValue:[NSNumber numberWithInt:2] forKey:@"userid"];*/
    NSMutableDictionary * userDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userdic"] mutableCopy];

    
    APIHandler *api = [[APIHandler alloc]init];
    [General startLoader:self.view];

    [api API_EXAM_RESULTS:userDic withSuccess:^(id result)
    {
        resultArr = [[NSMutableArray alloc]init];
        
        examTitle = [[NSMutableArray alloc]init];
        
        if ([result[@"status"]boolValue])
        {
            resultArr = [result[@"response"]mutableCopy];
            if (resultArr.count > 0)
            {
                for (NSDictionary *temp in resultArr)
                {
                    [examTitle addObject:[temp valueForKey:@"examTitle"]];
                    
                }
                [self updateUI:0];
            }
            else
            {
                [self.tblExam addSubview:nodata];
            }
            
            [self.tblExam reloadData];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateUI:(NSInteger)row
{
    NSDictionary *temp = [resultArr objectAtIndex:row];
    selectedArr = [temp valueForKey:@"marks"];
    self.selectExamLbl.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"examTitle"]];
    self.markScroed.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"totalMarkscored"]];
    self.totalMark.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"totalMarks"]];
    self.cgp.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"gpa"]];
    self.status.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"examStatus"]];
    if (selectedArr.count>0)
    {
        [nodata removeFromSuperview];
    }
    else
    {
        [self.tblExam addSubview:nodata];
    }
    [self.tblExam reloadData];


}
#pragma Mark TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectedArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
    TableViewCell *cell = [nib objectAtIndex:0];
    NSDictionary *markdic = [selectedArr objectAtIndex:indexPath.row];
    cell.subject.text = [NSString stringWithFormat:@"%@",[markdic valueForKey:@"subject"]];
    cell.mark.text = [NSString stringWithFormat:@"%@",[markdic valueForKey:@"marks"]];
    cell.grade.text = [NSString stringWithFormat:@"%@",[markdic valueForKey:@"grade"]];
    cell.comment.text = [NSString stringWithFormat:@"%@",[markdic valueForKey:@"comments"]];

    self.tblExam.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row%2==0)
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor=[UIColor lightGrayColor];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
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
- (IBAction)selectExamAction:(UIButton *)sender
{
    UIView *baseview = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-244, [UIScreen mainScreen].bounds.size.width, 214)];
    [baseview setBackgroundColor: [UIColor whiteColor]];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];

    UIButton *dnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dnBtn setTitle:@"DONE" forState:UIControlStateNormal];
    dnBtn.titleLabel.font = [UIFont fontWithName:THEME_FONT size:16.0];
    dnBtn.frame=CGRectMake(0.0, 0.0, 80.0, 44.0);
    [dnBtn setTitleColor:DARK_BG forState:UIControlStateNormal];
    [dnBtn addTarget:self action:@selector(doneBtnPressToGetValue) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*UIButton *clrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clrBtn setTitle:@"CANCEL" forState:UIControlStateNormal];
    clrBtn.titleLabel.font = [UIFont fontWithName:THEME_FONT size:16.0];
    clrBtn.frame=CGRectMake(0.0, 0.0, 80.0, 44.0);
    [clrBtn setTitleColor:DARK_BG forState:UIControlStateNormal];
    [clrBtn addTarget:self action:@selector(cancelBtnPressToGetValue) forControlEvents:UIControlEventTouchUpInside];
    
    */
    UIBarButtonItem *donebtn =  [[UIBarButtonItem alloc] initWithCustomView:dnBtn];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
   /* UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithCustomView:clrBtn];*/
    toolBar.translucent=NO;
    toolBar.barTintColor=THEME_COLOR;
    
    //[toolBar setItems:[NSArray arrayWithObjects:clearButton,flexible,donebtn,nil]];
    [toolBar setItems:[NSArray arrayWithObjects:flexible,donebtn,nil]];

    [baseview addSubview:toolBar];
    
    UIPickerView *valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 170)];
    valuePicker.delegate=self;
    valuePicker.dataSource=self;
    valuePicker.showsSelectionIndicator=YES;
    valuePicker.backgroundColor = BG_COLOR;
    [baseview addSubview:valuePicker];
    [bgView addSubview:baseview];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:bgView];

}

- (void)doneBtnPressToGetValue
{
    [self updateUI:selectedIndex];
    [bgView removeFromSuperview];
}
- (void)cancelBtnPressToGetValue
{
    [bgView removeFromSuperview];
}

#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return examTitle.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(examTitle.count == 0)
    {
        return @"No data available";
    }
    else
    {
        return [examTitle objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *temp = [resultArr objectAtIndex:row];
    self.selectExamLbl.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"examTitle"]];
    selectedIndex = row ;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSString *title;
    if(examTitle.count == 0)
    {
        title =   @"No data available";
    }
    else
    {
        title =  [examTitle objectAtIndex:row];
    }
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:THEME_FONT size:22]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setTextColor:THEME_COLOR];
        tView.numberOfLines=3;
        selectedIndex = 0;
        NSDictionary *temp = [resultArr objectAtIndex:0];
        self.selectExamLbl.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"examTitle"]];

    }
    tView.text=title;
    return tView;
}


@end
