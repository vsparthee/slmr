//
//  General.h
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface General : NSObject
+(void)setupNavigationBarStyle:(UINavigationController*)navigationController;
+(void)setShadow:(UIView *)view
      withRadius:(int)radius
 withshadowColor:(UIColor*)color
withclipsToBounds:(BOOL)val
withShadowOpacity:(float)opacity
withShadowRadius:(float)shadow_radius;

+(void)setLabelFormat:(UILabel *)lbl withFontType:(NSString*)selectedFont withFontSize:(int)fontSize withFontColor:(UIColor*)color withFontAlignment:(NSTextAlignment)alignment;

+(void)setupTextField:(ACFloatingTextField *)textfield;

+(void)vcTitleLableSetup:(UILabel*)lbl;

+(void)setShadowForLabel : (UILabel *)view;

+(void)startLoader:(UIView*)view;
+(void)stopLoader;
//+(void)showAlert:(NSString *)Subtitle withDelegate:(id)delegateid withbuttonTitle:(NSArray*)titleArr;

+(void)animateViewWitView :(UIView *)view;
+(void)makeToast:(NSString *)msg withToastView:(id)toastView;

+(void)json:(NSDictionary*)dic;













@end
