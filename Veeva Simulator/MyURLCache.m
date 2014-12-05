//
//  MyURLCache.m
//  Veeva Simulator
//
//  Created by Michael Caron on 2014-11-21.
//  Copyright (c) 2014 JJ Mifsud. All rights reserved.
//

#import "MyURLCache.h"

@implementation MyURLCache

- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    NSString * ext = [[[request URL] absoluteString] pathExtension];
    
    if ([ext caseInsensitiveCompare:@"css"] == NSOrderedSame) {
        return nil;
    } else if([ext caseInsensitiveCompare:@"js"] == NSOrderedSame) {
        return nil;
    } else {
        return [super cachedResponseForRequest:request];
    }
}

@end
