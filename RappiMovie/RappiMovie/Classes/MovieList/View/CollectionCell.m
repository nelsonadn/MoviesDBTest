//
//  CollectionCell.m
//  UICollectionView
//
//  Created by Carlos Butron on 31/08/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

#import "CollectionCell.h"
#import "FrameCollectionViewCell.h"

@implementation CollectionCell

@synthesize collectionView, collectionArray, backgroundImage, titleLabel, subTitleLabel, stringImageName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

-(void)loadBackgroundImage{
    if (self.stringImageName) {
        NSString *stringURL = [NSString stringWithFormat:@"%@/%@", URL_IMAGE, self.stringImageName];
        self.backgroundImage.image = [UIImage imageNamed:@"Movie_placeholderCover"];
        self.businessLogic = [[BusinessLogic alloc] init];
        self.businessLogic.delegate = self;
        [self.businessLogic downloadAndCacheImageFromUrl:stringURL isPoster:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self loadBackgroundImage];
}

- (void)reloadInputViews{
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 225);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets=UIEdgeInsetsMake(1, 1, 1, 1);
    return insets;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionCell";
    FrameCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.movieDetailDict = [self.collectionArray objectAtIndex:indexPath.row];
    [cell reloadInputViews];
    return cell;
}

#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[ViewLogic sharedInstance] goToMovieDetailViewController:[NSString stringWithFormat:@"%@", [[self.collectionArray valueForKey:@"id"] objectAtIndex:indexPath.row]]];
}

#pragma mark BusinessLogicDelegate

-(void)returnImageFromURL:(BusinessLogic*)businessLogic image:(UIImage*)image isPoster:(BOOL)isPoster{
    self.backgroundImage.image = image;
}

@end
