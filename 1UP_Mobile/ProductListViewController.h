//
//  ProductListViewController.h
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeOrderViewController.h"

@interface ProductListViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *collectionview_ProductList;
    
    NSArray *arr_ProductList;
}
@end
