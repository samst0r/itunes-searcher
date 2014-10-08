//
//  SWAlbumTableViewCell.h
//  MonitizeCreate
//
//  Created by Samuel Ward on 08/10/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAlbumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackName;

@end
