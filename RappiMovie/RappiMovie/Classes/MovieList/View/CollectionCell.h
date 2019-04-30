//
//  CollectionCell.h
//  UICollectionView
//
//  Created by Carlos Butron on 31/08/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, BusinessLogicDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (nonatomic) BusinessLogic *businessLogic;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) NSString *stringImageName;
@property (nonatomic) BOOL isLoadedCell;
@property (weak, nonatomic) NSArray *collectionArray;

@end
