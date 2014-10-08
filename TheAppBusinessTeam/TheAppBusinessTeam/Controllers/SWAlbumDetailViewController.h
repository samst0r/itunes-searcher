//
//  SWTeamDetailViewController.h
//  MonitizeCreate
//
//  Created by Samuel Ward on 15/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWCircularImageView;

@interface SWAlbumDetailViewController : UIViewController

@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *priceName;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) UIImage *headshotImage;

@end
