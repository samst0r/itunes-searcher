//
//  SWWebsiteScrapper.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SWRequest.h"
#import "SWJSONParser.h"
#import "SWAlbum.h"

static NSString *websiteURL = @"http://itunes.apple.com/search?term=%@";

@implementation SWRequest

+ (void)downloadDataForSearchTerm:(NSString *)searchTerm withCompletionBlock:(void (^)(BOOL success, NSArray *albums))completionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:websiteURL,
                                                                               [searchTerm stringByReplacingOccurrencesOfString:@" "
                                                                                                                                                           withString:@"+"]]]
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:24 * 60];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {

                completionBlock((error == nil), [SWJSONParser parseAlbumsFromData:data]);
                
            }] resume];
}

+ (void)downloadImageFromURL:(NSURL *)url
         withCompletionBlock:(void (^)(BOOL success, UIImage *image))completionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:24 * 60];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    
                    UIImage *image = [UIImage imageWithData:data];
                    
                    completionBlock((error == nil), image);
                    
                }] resume];
}

@end

