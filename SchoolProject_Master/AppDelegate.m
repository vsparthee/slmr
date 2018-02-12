//
//  AppDelegate.m
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "AppDelegate.h"
#import "InOutReportVC.h"
@import Firebase;
FCAlertView *alert;
@interface AppDelegate ()<FCAlertViewDelegate>
{
    UIViewController *leftMenuVC;
    InOutReportVC *in_out;
}
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [FIRApp configure];
    [TSLanguageManager setSelectedLanguage:kLMEnglish];
    if ([[TSLanguageManager selectedLanguage] isEqualToString:@"ar"])
    {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    }

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LGSideMenuController *container = (LGSideMenuController *)self.window.rootViewController;
    UINavigationController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"DashboardNC"];
    leftMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    UINavigationController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"LoginNC"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([[defaults valueForKey:@"isLogin"]boolValue]==YES)
    {
        CGFloat screenWidth = 0.0;
        
        if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
        {
            screenWidth=[UIScreen mainScreen].bounds.size.height/3;
        }
        else
        {
            screenWidth=[UIScreen mainScreen].bounds.size.width/3;
        }
        if ([[TSLanguageManager selectedLanguage] isEqualToString:@"ar"])
        {
            [container setRootViewController:vc1];
            [container setLeftViewDisabled:true];
            [container setRightViewDisabled:FALSE];
            [container setRightViewController:leftMenuVC];
            container.rightViewWidth = screenWidth *2;
            container.rightViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
        }
        else
        {
            [container setRootViewController:vc1];
            [container setRightViewDisabled:true];
            [container setLeftViewDisabled:FALSE];
            [container setLeftViewController:leftMenuVC];
            container.leftViewWidth = screenWidth *2;
            container.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideAbove;
        }
        [self updateLocation];
    }
    else
    {
        [container setRootViewController:vc2];
        [container setLeftViewDisabled:true];
    }
    
    //[[NSUserDefaults standardUserDefaults] setObject:@"test" forKey:@"demo"];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);

    

    [NSTimer scheduledTimerWithTimeInterval:60
                                     target:self
                                   selector:@selector(targetMethod)
                                   userInfo:nil
                                    repeats:NO];
    return YES;
}

-(void) targetMethod
{
    [[NSUserDefaults standardUserDefaults] setObject:@"demo" forKey:@"demo"];
}
-(void)updateLocation
{
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0"))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
        {
            if(!error)
            {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER)
    {
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    double tolongitude = LONGITUTE;
    double tolatitude  = LATITUTE;
    
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=tolatitude;
    myCoordinate.longitude=tolongitude;
    CLLocationDistance radius = 500;
    CLCircularRegion *region1 = [[CLCircularRegion alloc]
                                 initWithCenter:myCoordinate
                                 radius:radius
                                 identifier:@"Test"];
    region1.notifyOnEntry = YES;
    region1.notifyOnExit = YES;
    
    [self.locationManager startMonitoringForRegion:region1];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void) locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *) newLocation
           fromLocation: (CLLocation *) oldLocation
{
    //[self.locationManager stopUpdatingLocation];
}
-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *in_min_str = IN_MIN_TIME;
    NSString *in_max_str = IN_MAX_TIME;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
    
    int in_min   = [self minutesSinceMidnight:[formatter dateFromString:in_min_str]];
    int in_max  = [self minutesSinceMidnight:[formatter dateFromString:in_max_str]];
    int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];
    
    NSString *out_min_str = OUT_MIN_TIME;
    NSString *out_max_str = OUT_MAX_TIME;
    
    int out_min   = [self minutesSinceMidnight:[formatter dateFromString:out_min_str]];
    int out_max  = [self minutesSinceMidnight:[formatter dateFromString:out_max_str]];
    
    if (in_min <= nowTime && nowTime <= in_max && [[defaults valueForKey:@"isIN"]boolValue]==NO)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
        {
            UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
            objNotificationContent.title = @"School Project";
            objNotificationContent.body = [NSString stringWithFormat:@"Enterd:%@",region.identifier];
            objNotificationContent.sound = [UNNotificationSound defaultSound];
            objNotificationContent.launchImageName = @"test";
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                          triggerWithTimeInterval:1.F repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
                                                                                  content:objNotificationContent trigger:trigger];
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
             {
                 if (!error)
                 {
                     NSLog(@"Local Notification succeeded");
                 }
                 else
                 {
                     NSLog(@"Local Notification failed");
                 }
             }];
        }
        else
        {
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
            localNotification.alertBody = [NSString stringWithFormat:@"Enterd:%@",region.identifier] ;
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }

    }
    else if (out_min <= nowTime && nowTime <= out_max && [[defaults valueForKey:@"isOUT"]boolValue]==NO)// && [[defaults valueForKey:@"isIN"]boolValue]==YES)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
        {
            UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
            objNotificationContent.title = @"School Project";
            objNotificationContent.body = [NSString stringWithFormat:@"Enterd:%@",region.identifier];
            objNotificationContent.sound = [UNNotificationSound defaultSound];
            objNotificationContent.launchImageName = @"test";
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                          triggerWithTimeInterval:1.F repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
                                                                                  content:objNotificationContent trigger:trigger];
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
             {
                 if (!error)
                 {
                     NSLog(@"Local Notification succeeded");
                 }
                 else
                 {
                     NSLog(@"Local Notification failed");
                 }
             }];
        }
        else
        {
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
            localNotification.alertBody = [NSString stringWithFormat:@"Enterd:%@",region.identifier] ;
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }

    }
    else
    {
        
    }

    
    /*
    NSDate *myDate = [NSDate date];
    NSTimeInterval latin = [[NSUserDefaults standardUserDefaults] floatForKey:@"last_in"];
    NSDate *lastindate = [NSDate dateWithTimeIntervalSince1970:latin];
    NSTimeInterval distanceBetweenDates = [myDate timeIntervalSinceDate:lastindate];
    double secondsInAnHour = 60;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    if (hoursBetweenDates>2)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
        {
            UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
            objNotificationContent.title = @"School Project";
            objNotificationContent.body = [NSString stringWithFormat:@"Enterd:%@",region.identifier];
            objNotificationContent.sound = [UNNotificationSound defaultSound];
            objNotificationContent.launchImageName = @"test";
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                          triggerWithTimeInterval:1.F repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
                                                                                  content:objNotificationContent trigger:trigger];
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
             {
                 if (!error)
                 {
                     NSLog(@"Local Notification succeeded");
                 }
                 else
                 {
                     NSLog(@"Local Notification failed");
                 }
             }];
        }
        else
        {
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
            localNotification.alertBody = [NSString stringWithFormat:@"Enterd:%@",region.identifier] ;
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    }*/
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
    //    {
    //        UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
    //        objNotificationContent.title = @"School Project";
    //        objNotificationContent.body = [NSString stringWithFormat:@"Exit:%@",region.identifier];
    //        objNotificationContent.sound = [UNNotificationSound defaultSound];
    //
    //        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
    //                                                      triggerWithTimeInterval:1.F repeats:NO];
    //        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
    //                                                                              content:objNotificationContent trigger:trigger];
    //        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
    //         {
    //             if (!error)
    //             {
    //                 NSLog(@"Local Notification succeeded");
    //             }
    //             else
    //             {
    //                 NSLog(@"Local Notification failed");
    //             }
    //         }];
    //    }
    //    else
    //    {
    //        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //        localNotification.alertBody = [NSString stringWithFormat:@"Exit:%@",region.identifier] ;
    //        localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //    }
}
-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Monitoring Started for region");
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSString *stateString = nil;
    switch (state)
    {
        case CLRegionStateInside:
            stateString = @"inside";
            break;
        case CLRegionStateOutside:
            stateString = @"outside";
            break;
        case CLRegionStateUnknown:
            stateString = @"unknown";
            break;
    }
    NSLog(@"stateString: %@",stateString);
    
}




- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    in_out = [storyboard instantiateViewControllerWithIdentifier:@"InOutReportVC"];
    [[self window].rootViewController presentViewController:in_out animated:YES completion:nil];
    completionHandler();
    
    
}

- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    
    // TODO: If necessary send token to application server.
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [FIRMessaging messaging].APNSToken = deviceToken;
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    [[NSUserDefaults standardUserDefaults] setObject:refreshedToken forKey:@"FIREBASE_TOKEN"];
    if (refreshedToken.length > 10)
    {
        [self registerToken:refreshedToken];
    }
    NSLog(@"refreshedToken: %@", refreshedToken);
}

-(void)registerToken:(NSString*)token
{
    APIHandler *api = [[APIHandler alloc]init];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc]init];
    
    [userDic setValue:token forKey:@"token"];
    [userDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [api API_REGISTER_TOKEN:userDic withSuccess:^(id result)
    {
        if ([result[@"status"]boolValue])
        {
            
        }
        else
        {
            
        }
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#if !TARGET_IPHONE_SIMULATOR
#endif
}

// With "FirebaseAppDelegateProxyEnabled": NO

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive) {
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        if([message isKindOfClass:[NSString class]] == YES)
        {
            [self showAlert:message];
        }
        else if ([message isKindOfClass:[NSDictionary class]] == YES)
        {
            NSString *bodyStr =[NSString stringWithFormat:@"%@",[[userInfo valueForKey:@"aps"] valueForKeyPath:@"alert.body"]];
            NSString *titleStr =[NSString stringWithFormat:@"%@",[[userInfo valueForKey:@"aps"] valueForKeyPath:@"alert.title"]];
            message =[NSString stringWithFormat:@"%@ \n %@",titleStr,bodyStr] ;
            [self showAlert:message];
        }
        
    }
    else
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber+1;
        //[(LeftMenuVC*)leftMenuVC selectrow:6 withTag:0 withData:@"test"];
    }
    
    
}
-(void)showAlert : (NSString *)msg
{
    
    
    NSString *message = msg;
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    alert.titleFont = [UIFont fontWithName:@"CenturyGothic-Bold" size:16];
    alert.subtitleFont = [UIFont fontWithName:@"CenturyGothic" size:15];
    alert.firstButtonBackgroundColor = THEME_COLOR;
    alert.secondButtonBackgroundColor = DARK_BG;
    alert.delegate = self;
    alert.bounceAnimations = YES;
    alert.hideDoneButton = YES;
    alert.customImageScale = 1.1;
    alert.titleColor = [UIColor darkGrayColor];
    alert.subTitleColor = [UIColor darkGrayColor];
    alert.firstButtonTitleColor = [UIColor whiteColor];
    alert.secondButtonTitleColor = [UIColor whiteColor];
    alert.colorScheme = DARK_BG;
    alert.avoidCustomImageTint = 1;
    
    
    [alert showAlertInView:self.window.rootViewController
                 withTitle:@"Data Space"
              withSubtitle:message
           withCustomImage:[UIImage imageNamed:@"Logo"]
       withDoneButtonTitle:nil
                andButtons:@[@"Ok"]];//@[@"Open", @"Close"]];
    
    
}

@end
