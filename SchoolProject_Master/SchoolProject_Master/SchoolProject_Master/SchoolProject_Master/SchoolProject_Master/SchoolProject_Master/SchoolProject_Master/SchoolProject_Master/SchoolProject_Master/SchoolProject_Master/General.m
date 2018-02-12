//
//  General.m
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "General.h"
#import <UIKit/UIKit.h>
DGActivityIndicatorView *activityIndicatorView;

@implementation General


+(void)setupNavigationBarStyle:(UINavigationController*)navigationController
{
    navigationController.navigationBar.hidden = TRUE;
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    navigationController.navigationBar.barTintColor = THEME_COLOR;
    
    // [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -10) forBarMetrics:UIBarMetricsDefault];
    
    navigationController.navigationBar.translucent = NO;
  //  [navigationController.navigationBar setTitleTextAttributes:
 //    @{NSForegroundColorAttributeName:[UIColor whiteColor],
  //     NSFontAttributeName:[UIFont fontWithName:Theme_Font_SemiBold size:15]}];
}

+(void)vcTitleLableSetup:(UILabel*)lbl
{
    //lbl.textColor = Theme_TitleText_Color;
   // lbl.font = [UIFont fontWithName:Theme_Font_SemiBold size:17];
    lbl.textAlignment = NSTextAlignmentCenter;

}

+(void)setShadowForLabel : (UILabel *)view
{
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds  = NO;
    view.clipsToBounds = YES;
    CGColorRef SHADOW_COLOR = [UIColor blackColor].CGColor;
    CGSize SHADOW_OFFSET = CGSizeMake(0.0,1.0);
    CGFloat SHADOW_OPACITY = 0.3;
    CGFloat SHADOW_RADIUS = 1.0;
    view.layer.shadowColor = SHADOW_COLOR;
    view.layer.shadowOffset = SHADOW_OFFSET;
    view.layer.shadowOpacity = SHADOW_OPACITY;
    view.layer.shadowRadius = SHADOW_RADIUS;
}


+(void)setShadow:(UIView *)view
      withRadius:(int)radius
 withshadowColor:(UIColor*)color
withclipsToBounds:(BOOL)val
withShadowOpacity:(float)opacity
withShadowRadius:(float)shadow_radius
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds  = NO;
    view.clipsToBounds = val;
    CGColorRef SHADOW_COLOR = color.CGColor;
    CGSize SHADOW_OFFSET = CGSizeMake(0.0,1.0);
    CGFloat SHADOW_OPACITY = opacity;
    CGFloat SHADOW_RADIUS = shadow_radius;
    view.layer.shadowColor = SHADOW_COLOR;
    view.layer.shadowOffset = SHADOW_OFFSET;
    view.layer.shadowOpacity = SHADOW_OPACITY;
    view.layer.shadowRadius = SHADOW_RADIUS;
}
+(void)setLabelFormat:(UILabel *)lbl withFontType:(NSString*)selectedFont withFontSize:(int)fontSize withFontColor:(UIColor*)color withFontAlignment:(NSTextAlignment)alignment
{
    lbl.textColor = color;
    lbl.font = [UIFont fontWithName:selectedFont size:fontSize];
    lbl.textAlignment = alignment;
    // [lbl sizeToFit];
    
}

+(void)setupTextField:(ACFloatingTextField *)textfield
{
    
}

+(void)startLoader:(UIView*)view
{
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:THEME_COLOR size:[UIScreen mainScreen].bounds.size.width / 12.0];
    activityIndicatorView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0);
    [view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}


+(void)stopLoader
{
    [activityIndicatorView stopAnimating];
}
/*
+(void)showAlert:(NSString *)Subtitle withDelegate:(id)delegateid withbuttonTitle:(NSArray*)titleArr
{
    NSString *message = Subtitle;
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    alert.titleFont = [UIFont fontWithName:Theme_Font_Regular size:22.0];
    alert.subtitleFont = [UIFont fontWithName:Theme_Font_Regular size:16.0];
    alert.firstButtonBackgroundColor = Theme_Color;
    alert.secondButtonBackgroundColor = Theme_Color;
    //[alert setAlertSoundWithFileName:@"Ding.mp3"];
    alert.delegate = delegateid;
    alert.bounceAnimations = YES;
    alert.hideDoneButton = YES;
    alert.customImageScale = 1.25;
    alert.titleColor = [UIColor darkGrayColor];
    alert.subTitleColor = [UIColor darkGrayColor];
    alert.firstButtonTitleColor = [UIColor whiteColor];
    alert.secondButtonTitleColor = [UIColor whiteColor];
   // alert.colorScheme = Theme_Color;
    alert.avoidCustomImageTint = YES;
    
    
    [alert showAlertInView:delegateid
                 withTitle:Theme_Title
              withSubtitle:message
           withCustomImage:Theme_Image
       withDoneButtonTitle:nil
                andButtons:titleArr];
    
}

*/
+(void)animateViewWitView :(UIView *)view
{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

+(void)makeToast:(NSString *)msg withToastView:(id)toastView
{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor whiteColor];
    style.backgroundColor = DARK_BG;
   // style.messageFont = [UIFont fontWithName:Theme_Font_Medium size:16];
    [CSToastManager setQueueEnabled:NO];
    [toastView makeToast:msg
                duration:2.0
                position:CSToastPositionBottom
                   title:nil
                   image:nil
                   style:style
              completion:nil];
}

+(void)json:(NSDictionary*)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON : %@",jsonString);
    }

}





@end
