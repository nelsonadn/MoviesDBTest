//
//  FrameCollectionViewCell.m
//  UICollectionView
//
//  Created by Carlos Butron on 31/08/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

#import "FrameCollectionViewCell.h"

@implementation FrameCollectionViewCell

@synthesize imageMovie, titleLabel, subTitleLabel, movieDetailDict;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)reloadInputViews{
    NSString *stringURL = [NSString stringWithFormat:@"%@/%@", URL_IMAGE, [self.movieDetailDict valueForKey:@"poster_path"]];
    self.imageMovie.image = [UIImage imageNamed:@"default-movie"];
    self.businessLogic = [[BusinessLogic alloc] init];
    self.businessLogic.delegate = self;
    [self.businessLogic downloadAndCacheImageFromUrl:stringURL isPoster:YES];
    self.titleLabel.text = [self.movieDetailDict valueForKey:@"original_title"];
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@ votes", [self.movieDetailDict valueForKey:@"vote_count"]];
}

- (void)drawRect:(CGRect)rect{
    //[self reloadInputViews];
}

#pragma mark BusinessLogicDelegate

-(void)returnImageFromURL:(BusinessLogic*)businessLogic image:(UIImage*)image isPoster:(BOOL)isPoster{
    self.imageMovie.image = image;
}

@end
