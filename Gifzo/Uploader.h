//
//  Uploader.h
//  Gifzo
//
//  Created by Hiroki Kato on 2013/05/23.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Uploader : NSObject

- (void)uploadVideoWithURL:(NSURL *)videoURL temporaryFileURL:(NSURL *)tempFileURL completion:(void (^)(NSURL *, NSError *))completionBlock;

@end
