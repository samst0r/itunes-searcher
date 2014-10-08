//
//  SWWebsiteParser.h
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWJSONParser : NSObject

+ (NSArray *)parseAlbumsFromData:(NSData *)data;

@end
