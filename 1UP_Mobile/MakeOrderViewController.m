//
//  MakeOrderViewController.m
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import "MakeOrderViewController.h"


#define STRIPE_TEST_PUBLIC_KEY @"pk_test_wjlDgmCcYnDSsVgXc88sfai5"
#define STRIPE_TEST_POST_URL @""

@interface MakeOrderViewController ()

@end

@implementation MakeOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrlView.scrollEnabled = YES;
    [scrlView setContentSize:CGSizeMake(self.view.frame.size.width, 568+390)];
    
    [self addTapGesturetoView:view_PayDone];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
    {
        UIView *myDoneButton = [self GetKeyboardDoneButton];
        txt_FirstName.inputAccessoryView = myDoneButton;
        txt_LastName.inputAccessoryView = myDoneButton;
        txt_CardNo.inputAccessoryView = myDoneButton;
        txt_CvvNo.inputAccessoryView = myDoneButton;
        txt_ExpirationMonth.inputAccessoryView = myDoneButton;
        txt_ExpirationYear.inputAccessoryView = myDoneButton;
        txt_AddressLine1.inputAccessoryView = myDoneButton;
        txt_AddressLine2.inputAccessoryView = myDoneButton;
        txt_City.inputAccessoryView = myDoneButton;
        txt_State.inputAccessoryView = myDoneButton;
        txt_ZipCode.inputAccessoryView = myDoneButton;
        txt_CountryName.inputAccessoryView = myDoneButton;
        txt_Comment.inputAccessoryView = myDoneButton;
    }
    
    [self addpickerView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicator;
    [self.view addSubview:activityIndicator];
    
    self.activityIndicator.center = self.view.center;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *standardDefault = [NSUserDefaults standardUserDefaults];
    txt_FirstName.text = [standardDefault valueForKey:@"f_name"];
    txt_LastName.text = [standardDefault valueForKey:@"l_name"];
    txt_CardNo.text = [standardDefault valueForKey:@"card_no"];
    txt_CvvNo.text = [standardDefault valueForKey:@"cvv_no"];
    txt_ExpirationMonth.text = [standardDefault valueForKey:@"exp_month"];
    txt_ExpirationYear.text = [standardDefault valueForKey:@"exp_year"];
    txt_AddressLine1.text = [standardDefault valueForKey:@"addline1"];
    txt_AddressLine2.text = [standardDefault valueForKey:@"addline2"];
    txt_City.text = [standardDefault valueForKey:@"city"];
    txt_State.text = [standardDefault valueForKey:@"state"];
    txt_ZipCode.text = [standardDefault valueForKey:@"zipcode"];
    txt_CountryName.text = [standardDefault valueForKey:@"country_name"];
}

#pragma mark - IBAction

-(IBAction)btn_BackTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Gesture

-(void)addTapGesturetoView:(UIView *)iv
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGestureToview:)];
    [iv addGestureRecognizer:singleTapGestureRecognizer];
}

-(void)handleSingleTapGestureToview:(UITapGestureRecognizer *)tapGestureRecognizer
{
    self.stripeCard = [[STPCardParams alloc] init];
    self.stripeCard.name = [txt_FirstName.text stringByAppendingString:txt_LastName.text];
    self.stripeCard.number = txt_CardNo.text;
    self.stripeCard.cvc = txt_CvvNo.text;
    self.stripeCard.expMonth = [txt_ExpirationMonth.text integerValue];
    self.stripeCard.expYear = [txt_ExpirationYear.text integerValue];
    self.stripeCard.addressLine1 = txt_AddressLine1.text;
    self.stripeCard.addressLine2 = txt_AddressLine2.text;
    self.stripeCard.addressCity = txt_City.text;
    self.stripeCard.addressState = txt_State.text;
    self.stripeCard.addressZip = txt_ZipCode.text;
    self.stripeCard.addressCountry = txt_CountryName.text;
    
    if ([self validateCustomerInfo])
    {
        NSUserDefaults *standardDefault = [NSUserDefaults standardUserDefaults];
        [standardDefault setValue:txt_FirstName.text forKey:@"f_name"];
        [standardDefault setValue:txt_LastName.text forKey:@"l_name"];
        [standardDefault setValue:txt_CardNo.text forKey:@"card_no"];
        [standardDefault setValue:txt_CvvNo.text forKey:@"cvv_no"];
        [standardDefault setValue:txt_ExpirationMonth.text forKey:@"exp_month"];
        [standardDefault setValue:txt_ExpirationYear.text forKey:@"exp_year"];
        [standardDefault setValue:txt_AddressLine1.text forKey:@"addline1"];
        [standardDefault setValue:txt_AddressLine2.text forKey:@"addline2"];
        [standardDefault setValue:txt_City.text forKey:@"city"];
        [standardDefault setValue:txt_State.text forKey:@"state"];
        [standardDefault setValue:txt_ZipCode.text forKey:@"zipcode"];
        [standardDefault setValue:txt_CountryName.text forKey:@"country_name"];
        
        
        [self performStripeOperation];
    }
}

-(void)performStripeOperation
{
    if ([STRIPE_TEST_PUBLIC_KEY isEqualToString:@""])
    {
        NSError *error = [NSError errorWithDomain:StripeDomain code:STPInvalidRequestError
                                         userInfo:@{
                                                    NSLocalizedDescriptionKey: @"Please specify a Stripe Publishable Key"
                                                        
                                                  }];
        NSLog(@"%@", error);
        return;
    }
    
    [self.activityIndicator startAnimating];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success Full" message:@"Token Has been Generated" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [[STPAPIClient sharedClient] createTokenWithCard:self.stripeCard completion: ^(STPToken *token, NSError *error) {
        
        [self.activityIndicator stopAnimating];
        
        if (error)
        {
            NSLog(@"Error In Token Genrator--->%@", error);
        }
        else
        {
            [self createBackendChargeWithToken:token completion:^(PKPaymentAuthorizationStatus status) {
//                NSLog(@"completed........%ld", (long)status);
                if (status == 0)
                {
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else
                {
                    
                }
                
            }];
        }
        
        
    }];
}

- (void)createBackendChargeWithToken:(STPToken *)token completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    NSURL *url = [NSURL URLWithString:@"https://example.com/token"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@&amount=%@", token.tokenId, @100];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   if (error)
                   {
                       completion(PKPaymentAuthorizationStatusFailure);
                   }
                   else
                   {
                       completion(PKPaymentAuthorizationStatusSuccess);
                   }
               }];
    [task resume];
}


-(BOOL)validateCustomerInfo
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please Try Again" message:@"Please Enter All Required Info" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    if (txt_FirstName.text.length == 0 || txt_LastName.text.length == 0 || txt_CardNo.text.length == 0 || txt_CvvNo.text.length == 0 || txt_ExpirationMonth.text.length == 0 || txt_ExpirationYear.text.length == 0 || txt_AddressLine1.text.length == 0 || txt_City.text.length == 0 || txt_State.text.length == 0 || txt_ZipCode.text.length == 0 || txt_CountryName.text.length == 0)
    {
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    NSError *error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    if (error)
    {
        alert.message = [error localizedDescription];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}


#pragma mark - CreateDone Button

- (UIView *)GetKeyboardDoneButton
{
    // create custom button
    
    UIView *vw_doneButton = [[UIView alloc]init];
    vw_doneButton.frame = CGRectMake(0, 163, self.view.frame.size.width, 40);
    vw_doneButton.backgroundColor = [UIColor colorWithRed:202.0f/255.0f green:212.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(vw_doneButton.frame.size.width-90, 5, 80, 30);
    [vw_doneButton addSubview:doneButton];
    
    doneButton.adjustsImageWhenHighlighted = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0)
    {
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    else
    {
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return vw_doneButton;
    
}

- (void)doneButton:(id)sender
{
    [self.view endEditing:TRUE];
    [scrlView setContentOffset:CGPointMake(0,0) animated:YES];
}


#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    keyboardHide = NO;
    
    if (textField.tag <= 13)
    {
        
        switch (textField.tag)
        {
            case 1:
                [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            case 2:
                [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            case 3:
                [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            case 4:
                [scrlView setContentOffset:CGPointMake(0, txt_CvvNo.center.y - 100) animated:YES];
                break;
            case 5:
                [scrlView setContentOffset:CGPointMake(0, txt_ExpirationMonth.center.y - 100) animated:YES];
                
                break;
            case 6:
                [scrlView setContentOffset:CGPointMake(0, txt_ExpirationYear.center.y - 100) animated:YES];
                break;
            case 7:
                [scrlView setContentOffset:CGPointMake(0, txt_AddressLine1.center.y - 100) animated:YES];
                break;
            case 8:
                [scrlView setContentOffset:CGPointMake(0, txt_AddressLine2.center.y - 100) animated:YES];
                break;
            case 9:
                [scrlView setContentOffset:CGPointMake(0, txt_City.center.y - 100) animated:YES];
                break;
            case 10:
                [scrlView setContentOffset:CGPointMake(0, txt_State.center.y - 100) animated:YES];
                break;
            case 11:
                [scrlView setContentOffset:CGPointMake(0, txt_ZipCode.center.y - 100) animated:YES];
                break;
            case 12:
                [scrlView setContentOffset:CGPointMake(0, txt_CountryName.center.y - 100) animated:YES];
                break;
            case 13:
                [scrlView setContentOffset:CGPointMake(0, txt_Comment.center.y - 100) animated:YES];
                break;
        }
    }
    else
    {
        [scrlView setContentOffset:CGPointMake(0,/*textField.center.y-140*/0) animated:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder)
    {
        [scrlView setContentOffset:CGPointMake(0,textField.center.y -140) animated:YES];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [scrlView setContentOffset:CGPointMake(0,0) animated:YES];
        [textField resignFirstResponder];
        return YES;
    }
    
    return NO;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 3)
    {
        // Only the 16 digits + 3 spaces
        if (range.location == 19)
        {
            return NO;
        }
        
        // Backspace
        if ([string length] == 0)
            return YES;
        
        if ((range.location == 4) || (range.location == 9) || (range.location == 14))
        {
            
            NSString *str    = [NSString stringWithFormat:@"%@ ",textField.text];
            textField.text   = str;
        }
    }
    
    return YES;
}

#pragma mark - AddPickerView

-(void)addpickerView
{
    arr_Month = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    
    arr_Year = [[NSArray alloc] initWithObjects:@"16", @"17", @"18", @"19", @"20", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", nil];
    
    UIPickerView *pickerview = [[UIPickerView alloc] init];
    pickerview.dataSource = self;
    pickerview.delegate = self;
    pickerview.showsSelectionIndicator = YES;
    txt_ExpirationMonth.inputView = pickerview;
    txt_ExpirationYear.inputView = pickerview;
}

#pragma mark - PickerViewDatasource and Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return arr_Month.count;
    }
    else
    {
        return arr_Year.count;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        [txt_ExpirationMonth setText:[arr_Month objectAtIndex:row]];
    }
    else
    {
        [txt_ExpirationYear setText:[arr_Year objectAtIndex:row]];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [arr_Month objectAtIndex:row];
    }
    else
    {
        return [arr_Year objectAtIndex:row];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
