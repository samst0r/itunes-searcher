//
//  SWTeamMember.h
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAlbum : NSObject

@property (nonatomic, readonly, copy) NSString *albumName;
@property (nonatomic, readonly, copy) NSString *artistName;
@property (nonatomic, readonly, copy) NSString *trackName;
@property (nonatomic, readonly, copy) NSString *imageURL;
@property (nonatomic, readonly, copy) NSString *priceString;
@property (nonatomic, readonly, copy) NSString *releaseDateString;

@property (nonatomic) UIImage *image;

- (instancetype)initWithAlbumName:(NSString *)albumName
                       artistName:(NSString *)artistName
                        trackName:(NSString *)trackName
                         imageURL:(NSString *)imageURL
                      priceString:(NSString *)priceString
                releaseDateString:(NSString *)releaseDateString;

- (void)getImageWithCompletionBlock:(void (^)())completionBlock;

@end
