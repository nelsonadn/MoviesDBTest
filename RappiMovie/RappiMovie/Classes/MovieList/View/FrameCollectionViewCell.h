//
//  FrameCollectionViewCell.h
//  UICollectionView
//
//  Created by Carlos Butron on 31/08/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrameCollectionViewCell : UICollectionViewCell <BusinessLogicDelegate>

@property (strong, nonatomic) NSDictionary *movieDetailDict;
@property (weak, nonatomic) IBOutlet UIImageView *imageMovie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic) BusinessLogic *businessLogic;


@end
