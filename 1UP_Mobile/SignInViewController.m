//
//  SignInViewController.m
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTapGesturetoView:view_Done];
    
    [txt_Email setValue:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    [txt_Password setValue:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
    {
        UIView *myDoneButton = [self GetKeyboardDoneButton];
        txt_Email.inputAccessoryView = myDoneButton;
        txt_Password.inputAccessoryView = myDoneButton;
    }
}

#pragma mark - IBAction

-(IBAction)btn_BackTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btn_HelpTouched:(id)sender
{
    
}

-(IBAction)btn_SignUpViaFacebookTouched:(id)sender
{
    
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
    
    if (textField.tag <= 2)
    {
        
        switch (textField.tag)
        {
            case 1:
                [scrlView setContentOffset:CGPointMake(0,view_Email.center.y -140) animated:YES];
                break;
            case 2:
                [scrlView setContentOffset:CGPointMake(0,view_Password.center.y - 140) animated:YES];
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

#pragma mark - Gesture

-(void)addTapGesturetoView:(UIView *)iv
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGestureToview:)];
    [iv addGestureRecognizer:singleTapGestureRecognizer];
}

-(void)handleSingleTapGestureToview:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if ([txt_Email.text isEqualToString:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Email Field is Empty" message:@"Please Enter Your Email" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if ([txt_Password.text isEqualToString:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password Field is Empty" message:@"Please Enter Your Password" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSUserDefaults *standarddefault = [NSUserDefaults standardUserDefaults];
        [standarddefault setValue:@"Login Created" forKey:@"Login"];
        
        ProductListViewController *productlistViewController = (ProductListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProductListViewController"];
        [self.navigationController pushViewController:productlistViewController animated:YES];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
