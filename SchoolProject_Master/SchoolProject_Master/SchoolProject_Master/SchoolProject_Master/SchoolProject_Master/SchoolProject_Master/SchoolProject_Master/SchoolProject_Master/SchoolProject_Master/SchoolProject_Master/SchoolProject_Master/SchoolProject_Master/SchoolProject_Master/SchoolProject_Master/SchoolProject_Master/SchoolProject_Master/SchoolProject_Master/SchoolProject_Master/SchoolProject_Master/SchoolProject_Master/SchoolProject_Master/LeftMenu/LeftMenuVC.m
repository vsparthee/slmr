//
//  LeftMenuVC.m
//  CIC
//
//  Created by PPT-MAC-001 on 08/03/17.
//  Copyright © 2017 PPT-MAC-001. All rights reserved.
//

#import "LeftMenuVC.h"
#import "LeftMenuCell.h"

@interface LeftMenuVC ()
{
    
}
@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
}


-(void)setupVC
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
    //self.view.backgroundColor = theme_color;
    _titleArry = [NSArray arrayWithObjects:
                  [TSLanguageManager localizedString:@"Home"],
                  [TSLanguageManager localizedString:@"Finance Folder"],
                  [TSLanguageManager localizedString:@"Taxes Folder"],
                  [TSLanguageManager localizedString: @"Budget and Saverate"],
                  [TSLanguageManager localizedString:@"Numbers"],
                  [TSLanguageManager localizedString:@"Accident Reporting"],
                  [TSLanguageManager localizedString:@"Offers"],
                  [TSLanguageManager localizedString: @"Message & Notification"],
                  [TSLanguageManager localizedString:@"Contracts Appointments"],
                  [TSLanguageManager localizedString:@"Product Solutions"],
                  [TSLanguageManager localizedString:@"Videos"],
                  [TSLanguageManager localizedString:@"Discount"],
                  [TSLanguageManager localizedString:@"Recommendation"],
                  [TSLanguageManager localizedString: @"Documents"],
                  [TSLanguageManager localizedString:@"Consultor Profile"],
                  [TSLanguageManager localizedString:@"My Account"],
                  [TSLanguageManager localizedString: @"Setting"],
                  [TSLanguageManager localizedString:@"Signout"], nil];
    
    
    _imageArry = [NSArray arrayWithObjects:@"Home",@"Finance", @"Tax", @"Budget",@"phone",@"Accident Menu",@"offers",@"Message", @"Contracts",@"Product",@"Videos",@"discount",@"Recommandation",@"Document", @"consulter",@"User",@"settings", @"Sign Out Fill", nil];
    [self.tableView reloadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    LeftMenuCell *cell = (LeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil)
    {
        cell = [[LeftMenuCell alloc]init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.menuTitle.text = [_titleArry objectAtIndex:indexPath.row];
    cell.menuImg.image = [UIImage imageNamed:[_imageArry objectAtIndex:indexPath.row]];
    cell.menuImg.tintColor = BG_COLOR;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if(indexPath.row == 0)
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 1)
    {
       /* finance = [storyboard instantiateViewControllerWithIdentifier:@"FinanceFolderVC"];
        finance.parent=self;
        [self.sideMenuController setRootViewController:finance];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];*/
    }
    
   /* if(indexPath.row == 2)
    {
        tax = [storyboard instantiateViewControllerWithIdentifier:@"TaxFolderVC"];
        tax.parent=self;
        [self.sideMenuController setRootViewController:tax];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 3)
    {
        budget = [storyboard instantiateViewControllerWithIdentifier:@"BudgetAndSaveRateVC"];
        budget.parent=self;
        [self.sideMenuController setRootViewController:budget];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 4)
    {
        number = [storyboard instantiateViewControllerWithIdentifier:@"NumbersVC"];
        number.parent=self;
        [self.sideMenuController setRootViewController:number];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 5)
    {
        accreport = [storyboard instantiateViewControllerWithIdentifier:@"AccidentReportVC"];
        accreport.parent=self;
        [self.sideMenuController setRootViewController:accreport];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 6)
    {
        reqOffer = [storyboard instantiateViewControllerWithIdentifier:@"RequsetOfferVC"];
        reqOffer.parent=self;
        [self.sideMenuController setRootViewController:reqOffer];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }

    if(indexPath.row == 7)
    {
        msg = [storyboard instantiateViewControllerWithIdentifier:@"MessageVC"];
        msg.parent=self;
        [self.sideMenuController setRootViewController:msg];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 8)
    {
        appoinment = [storyboard instantiateViewControllerWithIdentifier:@"AppointmentVC"];
        appoinment.parent=self;
        [self.sideMenuController setRootViewController:appoinment];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 9)
    {
        product = [storyboard instantiateViewControllerWithIdentifier:@"ProductSolutionsVC"];
        product.parent=self;
        [self.sideMenuController setRootViewController:product];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 10)
    {
        video = [storyboard instantiateViewControllerWithIdentifier:@"VideoVC"];
        video.parent=self;
        [self.sideMenuController setRootViewController:video];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 11)
    {
        offer = [storyboard instantiateViewControllerWithIdentifier:@"OffersVC"];
        offer.parent=self;
        [self.sideMenuController setRootViewController:offer];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 12)
    {
        recommandation = [storyboard instantiateViewControllerWithIdentifier:@"RecommandationVC"];
        recommandation.parent=self;
        [self.sideMenuController setRootViewController:recommandation];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    
    if(indexPath.row == 13)
    {
        doc = [storyboard instantiateViewControllerWithIdentifier:@"DocumentList"];
        doc.parent=self;
        [self.sideMenuController setRootViewController:doc];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }

    if(indexPath.row == 14)
    {
        consultor = [storyboard instantiateViewControllerWithIdentifier:@"ConsultorProfileVC"];
        consultor.parent=self;
        [self.sideMenuController setRootViewController:consultor];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    if(indexPath.row == 15)
    {
        profile = [storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
        profile.parent=self;
        [self.sideMenuController setRootViewController:profile];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    
    
    if(indexPath.row == 16)
    {
        setting = [storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
        setting.parent=self;
        [self.sideMenuController setRootViewController:setting];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    if(indexPath.row == 17)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"myCashflow"
                                                                       message:@"Do you want logout?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                                                                  [self logout];

                                                              }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               }];
        
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }*/
   
}
-(void)logout
{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LGSideMenuController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LGSideMenuController"];
    UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNC"];
    UIViewController *leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    [rootViewController setRootViewController:homeVC];
    [rootViewController setLeftViewController:leftMenuVC];
    [rootViewController setLeftViewDisabled:true];
    CGFloat screenWidth = 0.0;
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        screenWidth=[UIScreen mainScreen].bounds.size.height/3;
    }
    else
    {
        screenWidth=[UIScreen mainScreen].bounds.size.width/3;
    }
    rootViewController.leftViewWidth = screenWidth *2.4;
    
    rootViewController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
    [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"setpwd"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profileImage"];

    
    

}




- (IBAction)homeAction:(id)sender {
    
  
    [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Login"])
    {
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"WalkthroughNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];

    }
    else{
        UINavigationController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardNC"];
        [self.sideMenuController setRootViewController:homeVC];
        [self.sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
    }
    */
}


@end
