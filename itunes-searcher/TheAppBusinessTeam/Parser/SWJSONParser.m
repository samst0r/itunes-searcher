//
//  SWWebsiteParser.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SWJSONParser.h"

#import "SWAlbum.h"

@implementation SWJSONParser

+ (NSArray *)parseAlbumsFromData:(NSData *)data {

    
    NSMutableArray *albums = [[NSMutableArray alloc] init];
    
    id jsonifiedJSON = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    
    for (id jsonElement in jsonifiedJSON[@"results"]) {
        
        NSString *artistName = jsonElement[@"artistName"];
        NSString *albumName = jsonElement[@"collectionName"];
        NSString *photoURL = jsonElement[@"artworkUrl60"];
        NSString *trackName = jsonElement[@"trackName"];
        NSString *priceString = [NSString stringWithFormat:@"%@ %@", jsonElement[@"collectionPrice"], jsonElement[@"currency"]];
        NSString *releaseDateString = jsonElement[@"releaseDate"];
        
        
        SWAlbum *album = [[SWAlbum alloc] initWithAlbumName:albumName
                                                 artistName:artistName
                                                  trackName:trackName
                                                   imageURL:photoURL
                                                priceString:priceString
                                          releaseDateString:releaseDateString];
        
        [albums addObject:album];
        
    }
    
    return albums;
}

@end
