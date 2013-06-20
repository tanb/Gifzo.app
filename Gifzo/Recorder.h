//
//  Recorder.h
//  Gifzo
//
//  Created by Kazato Sugimoto on 13/05/08.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@class Recorder;

@protocol RecorderDelegate <NSObject>
- (void)recorder:(Recorder *)recorder didRecordedWithOutputURL:(NSURL *)outputFileURL;
@end

@interface Recorder : NSObject <AVCaptureFileOutputRecordingDelegate> {
}

@property(weak) id <RecorderDelegate> delegate;

- (void)startRecordingWithOutputURL:(NSURL *)outputFileURL croppingRect:(NSRect)rect screen:(NSScreen *)screen;
- (void)finishRecording;

@end
