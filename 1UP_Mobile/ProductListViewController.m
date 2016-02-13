//
//  ProductListViewController.m
//  1UP_Mobile
//
//  Created by Dipesh on 11/02/16.
//  Copyright © 2016 Dipesh. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arr_ProductList = [[NSArray alloc] initWithObjects:@"watch_1.jpg", @"watch_2.jpg", @"watch_3.jpg", @"watch_4.jpg", @"watch_5.jpg", @"watch_6.jpg", nil];
}

#pragma mark - CollectionViewDataSource & Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_ProductList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imgview_Product = (UIImageView *)[cell viewWithTag:100];
    imgview_Product.image = [UIImage imageNamed:[arr_ProductList objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MakeOrderViewController *makeorderViewController = (MakeOrderViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MakeOrderViewController"];
    [self.navigationController pushViewController:makeorderViewController animated:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
