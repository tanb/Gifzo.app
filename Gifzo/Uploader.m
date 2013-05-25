//
//  Uploader.m
//  Gifzo
//
//  Created by Hiroki Kato on 2013/05/23.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Uploader.h"

#import "GifzoAPIClient.h"
#import "AFHTTPRequestOperation.h"

@implementation Uploader

- (void)uploadVideoWithURL:(NSURL *)videoURL temporaryFileURL:(NSURL *)tempFileURL completion:(void (^) (NSURL *gifURL, NSError *error))completionBlock
{
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetPassthrough];

    exportSession.outputURL = tempFileURL;
    exportSession.outputFileType = AVFileTypeMPEG4;

    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusCompleted:
                [self uploadVideo:exportSession.outputURL completion:completionBlock];

                break;
            case AVAssetExportSessionStatusFailed:
                completionBlock(nil, exportSession.error);

                break;
            case AVAssetExportSessionStatusCancelled:
                completionBlock(nil, nil);

                break;
            default:
                break;
        }
    }];
}

- (void)uploadVideo:(NSURL *)videoURL completion:(void (^) (NSURL *gifURL, NSError *error))completionBlock
{
    GifzoAPIClient *client = [GifzoAPIClient sharedClient];

    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST"
                                                                     path:@"/"
                                                               parameters:nil
                                                constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
                                                    NSError *error = nil;
                                                    [formData appendPartWithFileURL:videoURL name:@"data" error:&error];
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    }
                                                }];

    AFHTTPRequestOperation *requestOperation = [client
            HTTPRequestOperationWithRequest:request
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSString *gifURLString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                        NSURL *gifURL = [NSURL URLWithString:gifURLString];
                                        completionBlock(gifURL, nil);
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        completionBlock(nil, error);
                                    }];

    [client enqueueHTTPRequestOperation:requestOperation];
}

@end
