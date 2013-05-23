//
//  GifzoAPIClient.h
//  Gifzo
//
//  Created by Hiroki Kato on 2013/05/23.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface GifzoAPIClient : AFHTTPClient

+ (GifzoAPIClient *)sharedClient;

@end
