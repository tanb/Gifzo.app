//
//  AppDelegate.h
//  Gifzo
//
//  Created by Kazato Sugimoto on 13/05/02.
//  Copyright (c) 2013年 Kazato Sugimoto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DrawMouseBoxView.h"
#import "Recorder.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, DrawMouseBoxViewDelegate, RecorderDelegate>

@property Recorder *recorder;

@end
