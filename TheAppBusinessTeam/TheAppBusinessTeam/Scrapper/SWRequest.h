//
//  SWWebsiteScrapper.h
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRequest : NSObject

+ (void)downloadDataForSearchTerm:(NSString *)searchTerm
              withCompletionBlock:(void (^)(BOOL success, NSArray *albums))completionBlock;

+ (void)downloadImageFromURL:(NSURL *)url withCompletionBlock:(void (^)(BOOL success, UIImage *image))completionBlock;

@end
