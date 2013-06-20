//
//  DrawMouseBoxView.h
//  Gifzo
//
//  Created by Kazato Sugimoto on 13/05/02.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@class DrawMouseBoxView;

@protocol DrawMouseBoxViewDelegate <NSObject>
- (void)startRecordingKeyDidPressedInView:(DrawMouseBoxView *)view withRect:(NSRect)rect screen:(NSScreen *)screen;
@end

@interface DrawMouseBoxView : NSView

@property(weak) id <DrawMouseBoxViewDelegate> delegate;
@property NSScreen *screen;

@end
