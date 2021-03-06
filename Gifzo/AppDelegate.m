//
//  AppDelegate.m
//  Gifzo
//
//  Created by uiureo on 13/05/02.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import "AppDelegate.h"
#import "BorderlessWindow.h"
#import "Uploader.h"

@implementation AppDelegate {
    NSMutableArray *_windows;
    BOOL _isRecording, _recordingDidFinished;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.recorder = [[Recorder alloc] init];
    self.recorder.delegate = self;
    _isRecording = NO;

    [self startCropRect];
}

- (void)startRecording:(NSRect)cropRect screen:(NSScreen *)screen
{
    NSString *tempName = [self generateTempName];
    NSURL *movURL = [NSURL fileURLWithPath:[tempName stringByAppendingPathExtension:@"mov"]];

    [self.recorder startRecordingWithOutputURL:movURL croppingRect:cropRect screen:screen];

    _isRecording = YES;
}

#define kShadyWindowLevel   (NSScreenSaverWindowLevel + 1)

- (void)startCropRect
{
    _windows = [NSMutableArray array];

    for (NSScreen *screen in [NSScreen screens]) {
        NSRect frame = [screen frame];
        NSWindow *window = [[BorderlessWindow alloc] initWithContentRect:frame styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
        [window setBackgroundColor:[NSColor clearColor]];
        [window setOpaque:NO];
        [window setLevel:kShadyWindowLevel];
        [window setReleasedWhenClosed:YES];

        DrawMouseBoxView *drawMouseBoxView = [[DrawMouseBoxView alloc] initWithFrame:frame];
        drawMouseBoxView.screen = screen;
        drawMouseBoxView.delegate = self;

        [window setContentView:drawMouseBoxView];
        [window makeKeyAndOrderFront:self];
        [_windows addObject:window];
    }
}

#pragma mark - DrawMouseBoxViewDelegate
- (void)startRecordingKeyDidPressedInView:(DrawMouseBoxView *)view withRect:(NSRect)rect screen:(NSScreen *)screen
{
    if (_recordingDidFinished) return;

    if (_isRecording) {
        [self.recorder finishRecording];
        _recordingDidFinished = YES;
    } else {
        [self startRecording:rect screen:screen];
    }
}

#pragma mark - RecorderDelegate
- (void)recorder:(Recorder *)recorder didRecordedWithOutputURL:(NSURL *)outputFileURL
{
    [_windows makeObjectsPerformSelector:@selector(close)];

    NSString *tempName = [self generateTempName];
    NSURL *tempURL = [NSURL fileURLWithPath:[tempName stringByAppendingPathExtension:@"mp4"]];

    Uploader *uploader = [[Uploader alloc] init];
    [uploader uploadVideoWithURL:outputFileURL temporaryFileURL:tempURL completion:^(NSURL *gifURL, NSError *error) {
        if (gifURL) {
            [self copyToPasteboard:[gifURL absoluteString]];
            [[NSWorkspace sharedWorkspace] openURL:gifURL];
        }
        else if (error) {
            NSLog(@"Error : %@", error);
        }

        [NSApp terminate:nil];
    }];
}

- (NSString *)generateTempName
{
    char *tempNameBytes = tempnam([NSTemporaryDirectory() fileSystemRepresentation], "Gifzo_");
    NSString *tempName = [[NSString alloc] initWithBytesNoCopy:tempNameBytes length:strlen(tempNameBytes) encoding:NSUTF8StringEncoding freeWhenDone:YES];

    return tempName;
}

- (void)copyToPasteboard:(NSString *)urlString
{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil] owner:nil];
    [pasteboard setString:urlString forType:NSPasteboardTypeString];
}

@end
