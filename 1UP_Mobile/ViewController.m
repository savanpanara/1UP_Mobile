//
//  ViewController.m
//  1UP_Mobile
//
//  Created by Dipesh on 10/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - IBAction

-(IBAction)btn_NextTouched:(id)sender
{
    SignInViewController *signinViewController = (SignInViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:signinViewController animated:YES];
}

-(IBAction)btn_SignUpTouched:(id)sender
{
    SignUpViewController *signupViewController = (SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
