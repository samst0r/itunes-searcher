//
//  SWTeamMember.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SWAlbum.h"

@implementation SWAlbum

- (instancetype)initWithAlbumName:(NSString *)albumName
                       artistName:(NSString *)artistName
                        trackName:(NSString *)trackName
                         imageURL:(NSString *)imageURL
                      priceString:(NSString *)priceString
                releaseDateString:(NSString *)releaseDateString {
    
    self = [super init];
    
    if (self) {
        
        _albumName = [albumName copy];
        _artistName = [artistName copy];
        _trackName = [trackName copy];
        _imageURL = [imageURL copy];
        _priceString = [priceString copy];
        _releaseDateString = [releaseDateString copy];
    }
    
    return self;
}

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)getImageWithCompletionBlock:(void (^)())completionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    
    [[session dataTaskWithURL:[NSURL URLWithString:self.imageURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                __strong typeof(self) strongSelf = weakSelf;
                
                UIImage *image = [UIImage imageWithData:data];
                
                [SWAlbum imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
                
                strongSelf.image = image;
                
                completionBlock();
                
            }] resume];
}

@end
