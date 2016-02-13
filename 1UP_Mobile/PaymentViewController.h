//
//  PaymentViewController.h
//  1UP_Mobile
//
//  Created by Dipesh on 12/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Stripe/Stripe.h>

@interface PaymentViewController : UIViewController<STPPaymentCardTextFieldDelegate>
@property (nonatomic) STPPaymentCardTextField *paymentTextField;

@end
