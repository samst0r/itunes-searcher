//
//  SWTeamDetailViewController.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 15/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SWAlbumDetailViewController.h"
#import "SWCircularImageView.h"

@interface SWAlbumDetailViewController ()

@property (weak, nonatomic) IBOutlet SWCircularImageView *headShotImageView;
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

@end

@implementation SWAlbumDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.headShotImageView.image = self.headshotImage;
    self.trackNameLabel.text = [self.trackName copy];
    self.albumNameLabel.text = [self.albumName copy];
    self.artistNameLabel.text = [self.artistName copy];
    self.priceNameLabel.text = [self.priceName copy];
    self.releaseDateLabel.text = [self.releaseDate copy];
    
}

@end

