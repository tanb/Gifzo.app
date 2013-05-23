//
//  GifzoAPIClient.m
//  Gifzo
//
//  Created by Hiroki Kato on 2013/05/23.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import "GifzoAPIClient.h"
#import "AFHTTPRequestOperation.h"

static NSString * const kGifzoAPIBaseURLString = @"http://gifzo.net/";

@implementation GifzoAPIClient

+ (GifzoAPIClient *)sharedClient
{
    static GifzoAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[GifzoAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kGifzoAPIBaseURLString]];
    });

    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];

    return self;
}

@end
