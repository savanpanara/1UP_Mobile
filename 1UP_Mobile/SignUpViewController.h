//
//  SignUpViewController.h
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListViewController.h"

@interface SignUpViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    IBOutlet UIView *view_Done;
    IBOutlet UIView *view_Name;
    IBOutlet UIView *view_Email;
    IBOutlet UIView *view_Password;
    
    IBOutlet UIScrollView *scrlView;
    
    IBOutlet UITextField *txt_Name;
    IBOutlet UITextField *txt_Email;
    IBOutlet UITextField *txt_Password;
    
    BOOL keyboardHide;
    BOOL keyboardShow;
}

-(IBAction)btn_BackTouched:(id)sender;
-(IBAction)btn_SignUpViaFacebookTouched:(id)sender;
@end
