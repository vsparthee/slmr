//
//  AppDelegate.h
//  SchoolProject_Master
//
//  Created by Rishi on 11/25/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@import UserNotifications;
@import UserNotificationsUI;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic, assign) NSString *latStr;
@property(nonatomic, assign) NSString *longStr;


@end

