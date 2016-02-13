//
//  MakeOrderViewController.h
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Stripe/Stripe.h>

@interface MakeOrderViewController : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UIScrollView *scrlView;
    
    IBOutlet UIView *view_PayDone;
    
    IBOutlet UITextField *txt_FirstName;
    IBOutlet UITextField *txt_LastName;
    IBOutlet UITextField *txt_CardNo;
    IBOutlet UITextField *txt_CvvNo;
    IBOutlet UITextField *txt_ExpirationMonth;
    IBOutlet UITextField *txt_ExpirationYear;
    IBOutlet UITextField *txt_AddressLine1;
    IBOutlet UITextField *txt_AddressLine2;
    IBOutlet UITextField *txt_City;
    IBOutlet UITextField *txt_State;
    IBOutlet UITextField *txt_ZipCode;
    IBOutlet UITextField *txt_CountryName;
    IBOutlet UITextField *txt_Comment;
    
    BOOL keyboardHide;
    BOOL keyboardShow;
    
    NSArray *arr_Month;
    NSArray *arr_Year;
}

-(IBAction)btn_BackTouched:(id)sender;

@property (strong, nonatomic) STPCardParams *stripeCard;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@end
